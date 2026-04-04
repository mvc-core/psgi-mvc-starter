package MyApp::Controller::Login;

use strict;
use warnings;
use utf8;

use MyApp::DB;

sub index {
    my ($params, $env) = @_;

    my $session = $env->{'psgix.session'};
    my $dbh     = MyApp::DB::get_dbh();
    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    # Formular abgeschickt: User in Session speichern
    if ( $params->{user} ) {
        $session->{user} = $params->{user};
    }

    # Übermittelte Formular-Parameter für Template-Ausgabe
    my %subdata = %{ $params // {} };

    my %cookies = map {
        my ($k, $v) = split /=/, $_, 2;
        $k =~ s/^\s+|\s+$//g;
        $k => $v // ''
    } split /;\s*/, $env->{HTTP_COOKIE} // '';
    my $cookies = \%cookies;

    return {
        name    => 'Controller::Login: ' . $value,
	env     => $env,
	cookies => $cookies,
        xy      => "Frisch aus dem <b>Controller</b> lib/MyApp/Controller/Login.",
        subdata => \%subdata,
    };
}

1;
