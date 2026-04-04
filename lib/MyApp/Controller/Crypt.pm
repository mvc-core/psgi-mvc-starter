package MyApp::Controller::Crypt;

use strict;
use warnings;
use utf8;

# use MyApp::DB;
# XX use JSON qw(encode_json decode_json);

sub index {
    my ($params, $env) = @_;

    my $session = $env->{'psgix.session'};

    my $result;

    if ( $params->{in} ) {
    	$result->{out} = "asdfxx$$";
    }

    return {
        name    => 'Controller::Crypt',
	env     => $env,
	result  => $result,
	xy      => "Frisch v/<b>Controller</b> lib/MyApp/Controller/Crypt. $params->{in}"
    };
}

1;
