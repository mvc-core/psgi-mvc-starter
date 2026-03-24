package MyApp::DB;

use strict;
use warnings;
use DBI;

my $dbh;

sub get_dbh {
    $dbh //= DBI->connect(
        'dbi:mysql:dbname=db_local_602151;host=db-603220',
        'apache',
        'geHeimXX',
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
