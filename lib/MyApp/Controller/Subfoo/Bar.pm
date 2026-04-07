package MyApp::Controller::Subfoo::Bar;

use strict;
use warnings;
use MyApp::DB;

sub index {
    my $dbh = MyApp::DB::get_dbh();

    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    return {
        name => '***** Controller::Subfoo::Bar (604071) ***** &rarr; '.$value,
	xy   => "Ein anderes aus 604071 xy mit PID $$"
    };
}

1;
