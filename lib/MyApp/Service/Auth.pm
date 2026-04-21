package MyApp::Service::Auth;

use strict;
use utf8;
use warnings;

use Crypt::Argon2 qw/argon2id_pass argon2id_verify/;

my $dbh  = MyApp::DB::get_dbh();

sub authen {
	my %args = @_;

	my %res = ();
	   $res{rc} = 0;

	my $user = $args{user};
	my $pass = $args{pass};
	my $dbh  = MyApp::DB::get_dbh();

	my ($uid, $password_hash) = $dbh->selectrow_array(
		'SELECT id, password_hash FROM users WHERE uname = ? LIMIT 1',
		undef, $user
	);

	my $granted = my $f_argon_error = 0;
	eval { $granted = argon2id_verify($password_hash, $pass); };

	if ( $granted ) {
		$res{uid} = $uid;
	}
	else {
		$res{rc} = 1;
	}

	return \%res;
}

sub perm {
	my %args = @_;

	# -- my $perm = MyApp::Service::Auth::perm(env => $env);

	my %res = ();
	my $env = $args{env};

	my $session = $env->{'psgix.session'};

	return \%res unless $session->{uid};

	($res{is_admin}, $res{is_devel}, $res{uname}) = $dbh->selectrow_array(
		'SELECT is_admin, is_devel, uname FROM users WHERE id = ? LIMIT 1',
		undef, $session->{uid}
	);

	$res{uid} = $session->{uid};

	return \%res;
}

sub _is_logged_in {
	my ($env) = @_;
	my $session = $env->{'psgix.session'};

	my $is_logged_in = $session->{is_logged_in};

	return $is_logged_in;
}

1;
