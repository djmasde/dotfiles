# ============================================================================
# File:        glines.pl
# Author:      Crozz Cyborg <crozz@segv.sx>
# License:     GPLv3.
# ============================================================================
use strict;
use vars qw($VERSION %IRSSI);

use Irssi qw(signal_add_first);

$VERSION = '0.1';
%IRSSI = (
	authors     => 'Crozz Cyborg',
	contact     => 'crozz@segv.sx',
	name        => 'glinesforfree',
	description => 'glineforfree',
	license     => 'GPLv3');

sub join_chan{
	my ($server, $channel, $nick, $address) = @_;
	$channel =~ s/^://;

	if($channel eq "#glinesforfree"){
			$server->command("GLINE $nick 300 take your gline for free :D only today two glines for 1\$!!!");
	}
}


signal_add_first('event join', 'join_chan');