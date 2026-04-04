package MyApp::Controller::Foo;

use strict;
use warnings;

use MyApp::DB;
use Crypt::Lite;

my $crypt = Crypt::Lite->new( encoding => 'hex8 ');

sub index {
    my ($params, $env) = @_;

    my $dbh = MyApp::DB::get_dbh();

    my ($value) = $dbh->selectrow_array("SELECT firstname FROM users_addr LIMIT 1");

    my %cookies = map {
        my ($k, $v) = split /=/, $_, 2;
        $k =~ s/^\s+|\s+$//g;
        $k => $v // ''
    } split /;\s*/, $env->{HTTP_COOKIE} // '';
    my $cookies = \%cookies;

    return {
        name => "$value via Controller Foo",
	env  => $env,
	cookies => $cookies,
	xy   => "hhhDie PID ist jetzt gerade $$ / " . $crypt->encrypt('foo', 'bar')
    };
}

1;
