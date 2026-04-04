package MyApp::API;
use Dancer2;

set serializer => 'JSON';

get '/ping' => sub {
    return { status => 'ok' };
};

get '/me' => sub {
    return { user => 'demo' };
};

# mit ID
get '/me/:id' => sub {
    my $id = route_parameters->get('id');

    return {
        user => 'demo',
        id   => $id
    };
};

post '/secure' => sub {
    my $auth = request->header('Authorization');

    return send_error('Unauthorized', 401)
        unless $auth && $auth =~ /^Bearer (.+)$/;

    my $token = $1;

    return send_error('Forbidden', 403)
        unless $token eq 'secret';

    # JSON-Payload holen
    my $data = request->data;

    return send_error('Invalid JSON', 400)
        unless $data && ref $data eq 'HASH';

    # Optional einzelne Felder extrahieren
    my $user     = $data->{user};
    my $password = $data->{password};
    my $tenant   = $data->{tenant} // '* No tenant *';

    return {
        ok  => 1,
        api_version => 0.8001,
        msg => "Username was $user, PID $$, Req from $tenant, resp from $ENV{HOSTNAME}"
    };
};

1;
