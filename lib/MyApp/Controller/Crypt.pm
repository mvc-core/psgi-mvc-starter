package MyApp::Controller::Crypt;

use strict;
use warnings;
use utf8;

use MyApp::DB;
use LWP::UserAgent;
use HTTP::Request;
use JSON qw(encode_json decode_json);
# XX use MyApp::Service::Auth;

sub index {
    my ($params, $env) = @_;

    my $session = $env->{'psgix.session'};
    my $dbh     = MyApp::DB::get_dbh();
    # XXX my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    my $result;
    # XX my $token = 'secret';
    
    return {
        name    => 'Controller::Crypt',
	env     => $env,
	cookies => $cookies,
	result  => $result,
	xy      => "Frisch v/<b>Controller</b> lib/MyApp/Controller/Login. $params->{user}"
    };
}

1;
