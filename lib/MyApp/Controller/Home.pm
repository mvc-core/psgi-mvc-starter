package MyApp::Controller::Home;

use strict;
use warnings;

use MyApp::DB;

sub index {
    my ($params, $env) = @_;

    my $dbh = MyApp::DB::get_dbh();

    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    return {
        name => 'iii'.$value,
	env  => $env
    };
}

1;
