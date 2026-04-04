package MyApp::Controller::Login;

use strict;
use warnings;
use utf8;

use MyApp::DB;
use LWP::UserAgent;
use HTTP::Request;
use JSON qw(encode_json decode_json);

sub index {
    my ($params, $env) = @_;

    my $session = $env->{'psgix.session'};
    my $dbh     = MyApp::DB::get_dbh();
    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    my $result;
    my $token = 'secret';

    my $ua  = LWP::UserAgent->new;
    my $req = HTTP::Request->new(
        POST => 'https://psgi.h3.zspace.ch/api/secure',
        [
            'Authorization' => "Bearer $token",
            'Content-Type'  => 'application/json',
        ],
        encode_json({ user => $params->{user}, password => $params->{pass}, tenant => $env->{HTTP_HOST} })
    );
    my $res = $ua->request($req);
    $result = decode_json($res->decoded_content) if $res->is_success;

    # Formular abgeschickt: User in Session speichern
    if ( $params->{user} ) {
        $session->{user} = $params->{user};
    }

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
