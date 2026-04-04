package MyApp::Util::Crypt;

use strict;
use utf8;
use warnings;

sub encrypt {
	my $self = shift;

	my %args = @_;

	my $in = $args{in};

	my %res = (
		message => "Input was $in",
		out     => "tbd$$",
		aha     => "604041xy\-$in"
	);

	return \%res;
}

1;
