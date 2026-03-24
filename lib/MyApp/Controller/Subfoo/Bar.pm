package MyApp::Controller::Subfoo::Bar;

use strict;
use warnings;
use MyApp::DB;

sub index {
    my $dbh = MyApp::DB::get_dbh();

    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    return {
        name => '***** Controller::Subfoo::Bar ***** &rarr; '.$value,
	xy   => "Ein anderes xy mit $$"
    };
}

1;
