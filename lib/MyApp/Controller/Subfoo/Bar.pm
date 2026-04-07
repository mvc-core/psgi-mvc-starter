package MyApp::Controller::Subfoo::Bar;

use strict;
use warnings;
use MyApp::DB;

sub index {
    my ($params, $env) = @_;

    my $dbh = MyApp::DB::get_dbh();

    if ( $env->{PATH_INFO} =~ /\/4322$/ ) {
        print STDERR "XX ......... $env->{PATH_INFO} ... Interner Redirect zu /subfoo ...\n";
        return { _internal_redirect => '/subfoo' };
    }

    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    return {
        name => '***** Controller::Subfoo::Bar (604071) ***** &rarr; '.$value,
	xy   => "Ein anderes aus 604071 xy mit PID $$"
    };
}

1;
