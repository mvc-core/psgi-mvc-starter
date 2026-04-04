package MyApp::Util::Crypt;

use strict;
use utf8;
use warnings;

BEGIN { $^W = 0; }

use Sodium::FFI qw(
  crypto_aead_chacha20poly1305_ietf_encrypt
  crypto_aead_chacha20poly1305_ietf_decrypt
  crypto_aead_chacha20poly1305_IETF_NPUBBYTES
);

use MIME::Base64 qw(encode_base64 decode_base64);
use Encode qw(decode encode);

sub encrypt {
	my $self = shift;

	my %args = @_;

	my %res = ();
	my @msgs = ();

	my $plain = $args{plain};
        my $key   = $args{key} // '0123456789abcdef0123456789abcdef';
        my $nonce = pack("H*", '000000000000000000000000'); # -- 12 Byte (96 bit)
        my $ad    = undef; # -- Associated Data (optional)

	push(@msgs, "plain: $plain, key: $key");

	eval {
		$res{encrypted}        = crypto_aead_chacha20poly1305_ietf_encrypt($plain, $ad, $nonce, $key);
		$res{encrypted_base64} = encode_base64($res{encrypted}, '');
	} or
	do {
		$res{errmsg} = 'Error E604041';
	};

	$res{msg} = join ', ', @msgs;

	return \%res;
}

sub decrypt {
	my $self = shift;

	my %args = @_;

	my %res = ();
	my @msgs = ();

        my $key   = $args{key} // '0123456789abcdef0123456789abcdef';
        my $nonce = pack("H*", '000000000000000000000000'); # -- 12 Byte (96 bit)
        my $ad    = undef; # -- Associated Data (optional)

	eval {
		# -------- Decryption from base 64 encoded argument $args{encrypted_b64} here:
		$res{decrypted} = 'XX-constr';
	} or
	do {
		$res{errmsg} = 'Error E604041-63';
	};

	push(@msgs, 'XX decrypt: construction');
	push(@msgs, "XX enc was $args{encrypted_b64}");

	$res{msg} = join ', ', @msgs;

	return \%res;
}

1;
