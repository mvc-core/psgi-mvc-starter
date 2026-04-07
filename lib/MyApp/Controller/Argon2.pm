package MyApp::Controller::Argon2;

use strict;
use warnings;
use utf8;

use MyApp::DB;
use LWP::UserAgent;
use HTTP::Request;
use JSON qw(encode_json decode_json);
use MyApp::Service::Auth;

use Crypt::Argon2 qw/argon2id_pass argon2id_verify/;
use Bytes::Random::Secure qw(random_bytes random_bytes_base64 random_bytes_hex);

sub index {
    my ($params, $env) = @_;

    my $session = $env->{'psgix.session'};
    my $dbh     = MyApp::DB::get_dbh();
    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    my $result;
    my @msgs = ();
    my $token = 'secret';
    
    my $api_endpoint = 'https://psgi.h3.zspace.ch/api/secure';
       $api_endpoint = 'http://localhost/api/secure' if $env->{HTTP_HOST} eq 'psgi.h3.zspace.ch' or 1==1;

    (my $user = $params->{user}) =~ tr/ //d;

    my $password_hash = 'XXX';

    my $granted = my $f_argon_error = 0;
    eval { $granted = argon2id_verify($password_hash, $params->{pass}); };
    if ($@) {
    	my $errstr = "Error $@";
        push(@msgs, "E510252: $errstr");
        $f_argon_error = 1;
    }

    if ( $user ) {
        my $ua  = LWP::UserAgent->new;
        my $req = HTTP::Request->new(
            POST => $api_endpoint,
            [
                'Authorization' => "Bearer $token",
                'Content-Type'  => 'application/json',
            ],
            encode_json({ user => $params->{user}, password => $params->{pass}, tenant => $env->{HTTP_HOST} })
        );
        my $res = $ua->request($req);
        if ($res->is_success) {
            $result = decode_json($res->decoded_content);
        } else {
            $result = { errmsg => $res->status_line };
        }
        $session->{user} = $params->{user};
        $session->{is_logged_in} = 42;
    }

    $result->{XX_Auth__is_logged_in} = MyApp::Service::Auth::_is_logged_in($env);

    my %cookies = map {
        my ($k, $v) = split /=/, $_, 2;
        $k =~ s/^\s+|\s+$//g;
        $k => $v // ''
    } split /;\s*/, $env->{HTTP_COOKIE} // '';
    my $cookies = \%cookies;

    return {
        name    => 'Controller::Login: ' . $value,
	env     => $env,
	cookies => $cookies,
	result  => $result,
	xy      => "Frisch v/<b>Controller</b> lib/MyApp/Controller/Login. $params->{user}"
    };
}

1;
