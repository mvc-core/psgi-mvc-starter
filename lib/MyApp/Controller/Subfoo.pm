package MyApp::Controller::Subfoo;

use strict;
use warnings;

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

    return {
        name    => 'Controller::Subfoo: ' . $value,
	env     => $env,
        xy      => "Aus dem Controller Subfoo mit pid $$",
        subdata => \%subdata,
    };
}

1;
