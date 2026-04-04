package MyApp::Service::Auth;

use strict;
use utf8;
use warnings;
# XX use DBI;

my $dbh;
my $dbh_pid;

sub _test {
	my %foo = (
		aha => '604041xy'
	);
	return \%foo;
}

sub _is_logged_in {
	my $is_logged_in = 99;
	return $is_logged_in;
}

1;
