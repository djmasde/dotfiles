# ============================================================================
# File:        h4x0rl33t.pl
# Author:      Crozz Cyborg <crozz@segv.sx>
# Description: H4x0r L33t
# License:     GPLv3.
# ============================================================================
use strict;
use vars qw($VERSION %IRSSI);

use Irssi qw(signal_stop signal_add_first);

$VERSION = '0.1';
%IRSSI = (
	authors     => 'Crozz Cyborg',
	contact     => 'crozz@segv.sx',
	name        => 'h4x0rl33t',
	description => 'H4x0r L33t',
	license     => 'GPLv3');

my @a = ('4', '/\\', '/-\\');
my @e = ('3', '&', '€', '£', '[-', '|=-');
my @i = ('1', '!', '|', '¡', '][', ':', ']');
my @o = ('0', '()', '[]');
my @u = ('v', '|_|', '(_)', 'L|');

sub send_text{
	my($data, $server, $witem) = @_;
	return unless $witem;

	return unless($data =~ m#([aeiouAEIOU])#gi);

	$data =~ s/[aA]/$a[int(rand($#a+1))]/ge;
	$data =~ s/[eE]/$e[int(rand($#e+1))]/ge;
	$data =~ s/[iI]/$i[int(rand($#i+1))]/ge;
	$data =~ s/[oO]/$o[int(rand($#o+1))]/ge;
	$data =~ s/[uU]/$u[int(rand($#u+1))]/ge;

	$server->command("MSG $$witem{'name'} $data");
	signal_stop();
}

signal_add_first('send text', 'send_text');