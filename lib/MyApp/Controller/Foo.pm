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

    return {
        name => 'eee'.$value,
	env  => $env,
	xy   => "Die PID ist jetzt gerade $$ / " . $crypt->encrypt('foo', 'bar')
    };
}

1;
