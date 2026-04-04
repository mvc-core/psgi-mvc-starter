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
	    # XXX $result->{out} = "asdfxx$$";

	$result->{out} = MyApp::Util::Crypt->encrypt(
		plain => $params->{in} // 'foo'
	);
    }

    return {
        name    => 'Controller::Crypt',
	env     => $env,
	result  => $result,
	xy      => "Frisch v/<b>Controller</b> lib/MyApp/Controller/Crypt. $params->{in}"
    };
}

1;
