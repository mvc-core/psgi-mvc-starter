package MyApp::Service::Auth;

use strict;
use utf8;
use warnings;

sub _test {
	my %foo = (
		aha => '604041xy'
	);
	return \%foo;
}

sub _is_logged_in {
	my ($env) = @_;
	my $session = $env->{'psgix.session'};

	my $is_logged_in = $session->{is_logged_in};

	return $is_logged_in;
}

1;
