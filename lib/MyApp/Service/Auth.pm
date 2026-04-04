package MyApp::Service::Auth;

use strict;
use utf8;
use warnings;

# XX my $dbh;
# XX my $dbh_pid;

sub _test {
	my %foo = (
		aha => '604041xy'
	);
	return \%foo;
}

sub _is_logged_in {
	# my ($params, $env) = @_;
    	# my $session = $env->{'psgix.session'};

	my $is_logged_in = 97; # -- $session->{is_logged_in}

	return $is_logged_in;
}

1;
