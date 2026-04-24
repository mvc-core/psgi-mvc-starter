package MyApp::Controller::Internal;

use strict;
use warnings;

use POSIX qw(strftime);
use MyApp::DB;
use MyApp::Service::Auth;
use Crypt::Lite;
use ScreenPoint::Prism;

my $crypt = Crypt::Lite->new( encoding => 'hex8 ');

sub index {
    my ($params, $env) = @_;

    my $dbh = MyApp::DB::get_dbh();

    my $p   = ScreenPoint::Prism->new(dbh => $dbh);

    my @msgs = ();
    my @set_cookies = ();

    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    if ( $env->{PATH_INFO} =~ /\b\/set-cookie\b/ ) {
        push(@msgs, "XX set cookie $$");
        my $expires = strftime('%a, %d %b %Y %H:%M:%S GMT', gmtime(time() + 10800));
        push(@set_cookies, "myapp_testcookie_1=asdf%20$$; Path=/; Expires=$expires; HttpOnly");
        push(@set_cookies, "myapp_testcookie_2=asdx%20$$; Path=/");
    }

    my %cookies = map {
        my ($k, $v) = split /=/, $_, 2;
        $k =~ s/^\s+|\s+$//g;
        $k => $v // ''
    } split /;\s*/, $env->{HTTP_COOKIE} // '';
    my $cookies = \%cookies;

    my $msg = join ', ', @msgs;

    return {
        name        => "$value via Controller Foo",
        msg         => $msg,
	p           => $p,
        env         => $env,
	is_logged_in => MyApp::Service::Auth::_is_logged_in($env),
        cookies     => $cookies,
        xy          => "hhhDie PID ist jetzt gerade $$ / " . $crypt->encrypt('foo', 'bar'),
        _set_cookies => \@set_cookies,
    };
}

1;
