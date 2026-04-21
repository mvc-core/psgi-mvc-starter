package MyApp::Controller::Crypt;

use strict;
use warnings;
use utf8;

use MyApp::Util::Crypt;

sub index {
    my ($params, $env) = @_;

    my $session = $env->{'psgix.session'};

    my $result;

    if ( $params->{in} ) {
	$result->{out} = MyApp::Util::Crypt->encrypt(
		plain => $params->{in} // 'foo'
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
    # XXX my $cookies = \%cookies;

    return {
        name    => 'Controller::Crypt',
	env     => $env,
	cgi     => $params,
	result  => $result,
	cookies => \%cookies,
	xy      => "Frisch v/<b>Controller</b> lib/MyApp/Controller/Crypt. $params->{in}"
    };
}

1;
