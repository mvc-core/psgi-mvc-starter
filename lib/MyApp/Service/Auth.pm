package MyApp::Service::Auth;

use strict;
use utf8;
use warnings;

use Crypt::Argon2 qw/argon2id_pass argon2id_verify/;

sub authen {
	my %args = @_;

	my %res = ();

	my $user = $args{user};
	my $pass = $args{pass};
	my $dbh  = MyApp::DB::get_dbh();

	my ($password_hash) = $dbh->selectrow_array(
		'SELECT password_hash FROM users WHERE uname = ? LIMIT 1',
		undef, $user
	);

	my $granted = my $f_argon_error = 0;
	eval { $granted = argon2id_verify($password_hash, $pass); };

	$res{msg} = "XX ------ granted=$granted";

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
