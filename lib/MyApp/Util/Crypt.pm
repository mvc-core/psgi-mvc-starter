package MyApp::Util::Crypt;

use strict;
use utf8;
use warnings;

# XXX my $dbh;
# XX my $dbh_pid;

sub encrypt {
	my %args = @_;

	my $in = $args{in};

	my %foo = (
		aha => "604041xy\-$in"
	);

	return \%foo;
}

1;
