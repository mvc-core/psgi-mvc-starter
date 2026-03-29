package MyApp::DB;

use strict;
use warnings;
use DBI;

my $dbh;

sub get_dbh {
    $dbh //= DBI->connect(
        "dbi:mysql:dbname=$ENV{DB_NAME};host=$ENV{DB_HOST}",
        'apache',
        $ENV{DB_PASS},
        {
            RaiseError  => 1,
            AutoCommit  => 1,
            PrintError  => 0,
            mysql_enable_utf8 => 1,
        }
    );
    return $dbh;
}

1;
