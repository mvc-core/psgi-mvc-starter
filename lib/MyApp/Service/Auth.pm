package MyApp::Service::Auth;

use strict;
use utf8;
use warnings;

sub authen {
	my %args = @_;

	my %res = ();

	my $user = $args{user};
	my $pass = $args{pass};
	my $dbh  = MyApp::DB::get_dbh();

	my ($value) = $dbh->selectrow_array("SELECT password_hash FROM users LIMIT 1");

	$res{msg} = "XX $user / $value " . substr($pass, 0, 4) . '...';

	return \%res;
}

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
