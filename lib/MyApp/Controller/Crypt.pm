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
    	$result->{out} = "asdfxx$$";
	$result->{out2} = MyApp::Util::Crypt->encrypt(in=>'asdfuu');
    }

    return {
        name    => 'Controller::Crypt',
	env     => $env,
	result  => $result,
	xy      => "Frisch v/<b>Controller</b> lib/MyApp/Controller/Crypt. $params->{in}"
    };
}

1;
