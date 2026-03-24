package MyApp::Controller::Home;

use strict;
use warnings;
use MyApp::DB;

sub index {
    my $dbh = MyApp::DB::get_dbh();

    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    return {
        name => $value,
    };
}

1;
