package MyApp::Controller::Crypt;

use strict;
use warnings;
use utf8;

use MyApp::Util::Crypt;
use ScreenPoint::Prism;

my $dbh = MyApp::DB::get_dbh();

my $P = ScreenPoint::Prism->new( dbh => $dbh );

sub index {
    my ($params, $env) = @_;

    my $session = $env->{'psgix.session'};

    my $result;

    if ( $params->{in} ) {
	$result->{out} = MyApp::Util::Crypt->encrypt(
		plain => $params->{in} // 'foo',
		key   => $params->{key} || '0123456789abcdef0123456789abcdef'
	);
    }
    elsif ( $params->{enc} ) {
	$result->{out} = MyApp::Util::Crypt->decrypt(
		encrypted_b64 => $params->{enc}
	);
    }

    my %cookies = map {
        my ($k, $v) = split /=/, $_, 2;
        $k =~ s/^\s+|\s+$//g;
        $k => $v // ''
    } split /;\s*/, $env->{HTTP_COOKIE} // '';

    return {
        name    => 'Controller::Crypt',
	P       => $P,
	env     => $env,
	cgi     => $params,
	result  => $result,
	cookies => \%cookies,
	xy      => "Frisch v/<b>Controller</b> lib/MyApp/Controller/Crypt. $params->{in} <tt>\"$params->{key}\"</tt>"
    };
}

1;
