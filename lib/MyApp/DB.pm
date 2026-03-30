package MyApp::DB;

use strict;
use warnings;
use DBI;

my $dbh;

my %CONNECT_ARGS = (
    RaiseError        => 1,
    AutoCommit        => 1,
    PrintError        => 0,
    mysql_enable_utf8 => 1,
    mysql_auto_reconnect => 1,
);

sub _connect {
    $dbh = DBI->connect(
        "dbi:mysql:dbname=$ENV{DB_NAME};host=$ENV{DB_HOST}",
        'apache',
        $ENV{DB_PASS},
        \%CONNECT_ARGS,
    );
}

sub get_dbh {
    _connect() unless $dbh && $dbh->ping;
    return $dbh;
}

1;
