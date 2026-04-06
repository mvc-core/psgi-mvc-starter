package MyApp::Controller::Foo;

use strict;
use warnings;

use MyApp::DB;
use Crypt::Lite;

my $crypt = Crypt::Lite->new( encoding => 'hex8 ');

sub index {
    my ($params, $env) = @_;

    my $dbh = MyApp::DB::get_dbh();

    my @msgs = ();
    my @set_cookies = ();

    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    if ( $env->{PATH_INFO} =~ /\b\/set-cookie\b/ ) {
        push(@msgs, "XX set cookie $$");
        push(@set_cookies, "myapp_testcookie_1=asdf%20$$; Path=/");
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
        env         => $env,
        cookies     => $cookies,
        xy          => "hhhDie PID ist jetzt gerade $$ / " . $crypt->encrypt('foo', 'bar'),
        _set_cookies => \@set_cookies,
    };
}

1;
