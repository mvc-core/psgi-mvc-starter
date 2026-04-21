package MyApp::Controller::Login;

use strict;
use warnings;
use utf8;

use MyApp::DB;
use LWP::UserAgent;
use HTTP::Request;
use JSON qw(encode_json decode_json);
use MyApp::Service::Auth;
use ScreenPoint::Prism;

sub index {
    my ($params, $env) = @_;

    my $session = $env->{'psgix.session'};
    my $dbh     = MyApp::DB::get_dbh();
    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");
    my $P       = ScreenPoint::Prism->new(dbh => $dbh);

    my $result;
    my $msg   = '';
    my @msgs  = ();
    my $token = 'secret';
    
    my $api_endpoint = 'https://psgi.h3.zspace.ch/api/secure';
       $api_endpoint = 'http://localhost/api/secure' if $env->{HTTP_HOST} eq 'psgi.h3.zspace.ch' or 1==1;

    (my $user = $params->{user}) =~ tr/ //d;

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

	$result->{auth} = MyApp::Service::Auth::authen(
		user => $params->{user}, pass => $params->{pass}
	);

	# XXX $session->{is_logged_in} = $result->{auth}->{rc} ? 0 : 1;
	if ( $result->{auth}->{rc} ) {
		push(@msgs, "Error E604211: Login failed. RC  $result->{auth}->{rc}");
		$session->{user} = '';
	}
	else {
		$session->{user}         = $params->{user};
		$session->{uid}          = $result->{auth}->{uid};
		$session->{is_logged_in} = 1;
	}

	# XXX $msg = "XX [authen] - auth rc = $result->{auth}->{rc} / UID $result->{auth}->{uid}";
	push(@msgs, "XX [authen] - auth rc = $result->{auth}->{rc} / UID $result->{auth}->{uid}");
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
	P       => $P,
	env     => $env,
	cookies => $cookies,
	result  => $result,
	msg     => (join '<br>', @msgs),
	xy      => "Frisch v/<b>Controller</b> lib/MyApp/Controller/Login. $params->{user}"
    };
}

1;
