package MyApp::Util::Crypt;

use strict;
use utf8;
use warnings;

sub encrypt {
	my $self = shift;

	my %args = @_;

	my $in = $args{in};

	my %foo = (
		aha => "604041xy\-$in"
	);

	return \%foo;
}

1;
