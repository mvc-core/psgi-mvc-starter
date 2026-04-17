use strict;
use warnings;

use lib 'lib';

use Encode qw(encode_utf8);

use Mason::PluginManager;
use Mason::Interp;
use Plack::Request;
use Plack::Builder;
use Plack::Session::Store::File;
use Plack::Session::State::Cookie;

use MyApp::API; # Dancer2 API
# Dancer2 API App
my $api_app = MyApp::API->to_app;

# $current_output is set per-request via local() below.
# The out_method closure writes into it, making output capture safe
# für preforking servers like Starman (jeder Worker ist ein eigener Prozess).
our $current_output = '';

my $comp_root    = '/var/www/html/components';
my $session_dir  = '/tmp/myapp-sessions';
mkdir $session_dir unless -d $session_dir;

my $interp = Mason::Interp->new(
    comp_root        => $comp_root,
    mason_root_class => 'MyApp::Mason',
    out_method       => sub { $current_output .= $_[0] },
);

# ---------------------------------------------------------------------------
# Lazy Controller Dispatch
#
# Leitet /foo  -> MyApp::Controller::Foo::index($params, $env)
#         /    -> MyApp::Controller::Home::index($params, $env)
#
# require() lädt jedes Modul nur einmal pro Worker-Prozess (%INC-Cache).
# ---------------------------------------------------------------------------
sub _dispatch_controller {
    my $path = shift;

    # Pfadsegmente extrahieren und in Klassennamen-Teile umwandeln
    # /subfoo/bar  -> MyApp::Controller::Subfoo::Bar
    # /foo_bar/baz -> MyApp::Controller::FooBar::Baz
    # /            -> MyApp::Controller::Home
    my @segments = grep { length } split m{/}, $path;
    @segments = ('home') unless @segments;

    my @parts = map {
        join '', map { ucfirst( lc($_) ) } split /_/, $_
    } @segments;

    my $class = 'MyApp::Controller::' . join( '::', @parts );

    # Modul lazy laden (wird von %INC gecacht - kein Doppel-Load)
    unless ( $class->can('index') ) {
        ( my $file = $class ) =~ s{::}{/}g;
        eval { require "$file.pm" };
        if ($@) {
            warn "Controller nicht gefunden: $class ($@)";
            return undef;
        }
    }

    my $method = $class->can('index');
    return $method ? $method->(@_) : undef;
}

# ---------------------------------------------------------------------------
# Path Resolver – Detail-Route Fallback
#
# Prüft ob eine Mason-Komponente für den Pfad existiert.
# Falls nicht: letztes Segment als _id abtrennen und Parent prüfen.
#
# /foo/123        -> ($mason_path='/foo',        _id='123')  wenn foo.mc existiert
# /subfoo/bar/321 -> ($mason_path='/subfoo/bar', _id='321')  wenn subfoo/bar.mc existiert
# /subfox/123     -> ($mason_path='/subfox/123', _id=undef)  -> später 404
# ---------------------------------------------------------------------------
sub _resolve_path {
    my $path = shift;

    # Prüft ob eine .mc-Datei (direkt oder als index) für einen Pfad existiert
    my $component_exists = sub {
        my $p = shift;
        return -f "$comp_root$p.mc"
            || -f "$comp_root${p}/index.mc";
    };

    # Vollständiger Pfad existiert → kein Fallback nötig
    return ($path, undef) if $component_exists->($path);

    # Letztes Segment abtrennen und als potentiellen Parameter behandeln
    if ( $path =~ m{^(.+)/([^/]+)$} ) {
        my ($parent, $id) = ($1, $2);
        return ($parent, $id) if $component_exists->($parent);
    }

    # Nichts gefunden → Originalpath zurück (wird zu 404)
    return ($path, undef);
}

# ---------------------------------------------------------------------------
# PSGI App
# ---------------------------------------------------------------------------
my $app = sub {
    my $env = shift;

    my $path = $env->{PATH_INFO};
    $path =~ s/\.mc$//;
    my $is_root = ($path eq '' || $path eq '/');
    $path = '/index' if $is_root;

    # Statische Assets direkt mit 404 abweisen
    if ($path =~ /\.(ico|css|js|png|jpg|gif|svg|woff2?)$/i) {
        return [ 404, [ 'Content-Type' => 'text/plain' ], [ 'Not found' ] ];
    }

    # Detail-Route auflösen: ggf. letztes Segment als _id extrahieren
    my ($mason_path, $id) = _resolve_path($path);

    # GET- und POST-Parameter parsen
    my $req    = Plack::Request->new($env);
    my $params = $req->parameters->as_hashref;

    # Controller-Pfad: bei Root '/' verwenden, damit Home-Controller greift
    my $dispatch_path = $is_root ? '/' : $mason_path;

    # Controller für den aufgelösten Pfad laden ($params und $env weitergeben)
    my $data = _dispatch_controller($dispatch_path, $params, $env) // {};

    # Interner Redirect: Controller signalisiert Weiterleitung zu anderem Pfad
    if ( my $redirect_to = delete $data->{_internal_redirect} ) {
        ($mason_path, $id) = _resolve_path($redirect_to);
        $dispatch_path = $redirect_to;
        $data = _dispatch_controller($dispatch_path, $params, $env) // {};
        $path = $redirect_to;
    }

    # System-Werte eintragen (mit _ als Präfix um Kollisionen zu vermeiden)
    $data->{_path}    = $path;
    $data->{_id}      = $id if defined $id;
    $data->{_session} = $env->{'psgix.session'} // {};

    # Mason rendern
    local $current_output = '';
    eval {
        $interp->run($mason_path, data => $data);
    };
    if ($@) {
        my $err = $@;
        if ( ref($err) && $err->isa('Mason::Exception::TopLevelNotFound') ) {
            return [
                404,
                [ 'Content-Type' => 'text/html; charset=UTF-8' ],
                [ '<h1>404 Not Found</h1><p>Diese Seite existiert nicht.</p>' ],
            ];
        }
        warn "Mason error: $err";
        return [
            500,
            [ 'Content-Type' => 'text/plain' ],
            [ "Mason error: $err" ],
        ];
    }

    my @headers = ( 'Content-Type' => 'text/html; charset=UTF-8' );
    for my $cookie ( @{ $data->{_set_cookies} // [] } ) {
        push @headers, 'Set-Cookie' => $cookie;
    }

    return [
        200,
        \@headers,
        [ encode_utf8($current_output) ],
    ];
};

# ---------------------------------------------------------------------------
# Middleware-Stack
# ---------------------------------------------------------------------------
builder {
    # -----------------------------
    # API (separat gemountet)
    # -----------------------------
    mount "/api" => builder {

        enable 'Plack::Middleware::ContentLength';

	enable 'Plack::Middleware::CrossOrigin',
	    origins => '*',
	    headers => '*',
	    methods => 'GET,POST,PUT,DELETE,OPTIONS';

        $api_app;
    };

    # -----------------------------
    # Haupt-App (Mason)
    # -----------------------------
    mount "/" => builder {

        enable 'Session',
            store => Plack::Session::Store::File->new(
                dir => '/tmp/myapp-sessions'
            ),
            state => Plack::Session::State::Cookie->new(
                session_key => 'myapp_sid',
                httponly    => 1,
            );

        $app;
    };
};
