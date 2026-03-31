package MyApp::DB;

use strict;
use warnings;
use DBI;

my $dbh;
my $dbh_pid;

my %CONNECT_ARGS = (
    RaiseError        => 1,
    AutoCommit        => 1,
    PrintError        => 0,
    mysql_enable_utf8 => 1,
);

sub _connect {
    $dbh = DBI->connect(
        "dbi:mysql:dbname=$ENV{DB_NAME};host=$ENV{DB_HOST}",
        'apache',
        $ENV{DB_PASS},
        \%CONNECT_ARGS,
    );
    $dbh_pid = $$;
}

sub get_dbh {
    # Nach einem Fork hat der Child-Prozess eine andere PID als der Parent,
    # der die Verbindung ursprünglich aufgebaut hat. MySQL-Handles sind nicht
    # fork-safe — beide Prozesse würden denselben Socket teilen. Daher wird
    # der geerbte Handle mit InactiveDestroy deaktiviert (ohne den Socket des
    # Parents zu schließen) und eine neue Verbindung aufgebaut.
    if ($dbh && defined $dbh_pid && $dbh_pid != $$) {
        $dbh->{InactiveDestroy} = 1;
        undef $dbh;
    }

    _connect() unless $dbh && $dbh->ping;
    return $dbh;
}

1;
