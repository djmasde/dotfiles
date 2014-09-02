use strict;
use vars qw($VERSION %IRSSI);
# Audacious Irssi Script v1.0.4
#
# Change Log:
# v1.0.4:
#	- Added Repeat on/off capability
#	- Added Shuffle on/off capability
#	- Fixed script output handling for audacious version in case audacious isn't running
#	- If encountered a problem with audacious version, try changing `audacious --version` to `audtool -v`
# v1.0.3:
#	- Added Playlist functionality
#	- Added Song details (Bitrate/Frequency/Length/Volume)
#	- Current song notice with song details (Optional)
# v1.0.2:
#	- The script now handles warning support if you got audacious not running
#	- Added track number, current time elapse and total track time
#	- Added Stop functionality
# v1.0.1:
#	- Added ability to autonotify the channel after skipping a song (optional)
#	- Added Skip/Play/Pause/Resume calls
#
# How To Use?
# Copy your script into ~/.irssi/scripts/ directory
# Load your script with /script load audacious in your Irssi Client
# Type '/audacious help' in any channel for script commands
# For autoload insert your script into ~/.irssi/scripts/autorun/ directory
# Even better would be if you placed them in ~/.irssi/scripts/ and created symlinks in autorun directory
#
use Irssi;
$VERSION = '1.0.4';
%IRSSI = (
   authors	=>   "Dani Soufi",
   contact	=>   "IRC: FreeNode Network, #Ubuntu-LB",
   name		=>   "Audacious Irssi Script",
   description	=>   "Displays Current Song".
		     "Skips/Plays/Pauses/Stops/Resumes/Shuffles/Repeats Songs".
		     "Displays Script/Player's Current Version".
                     "Current Song Details",
   license      =>   "Public Domain",
);

sub cmd_song {
   my ($data, $server, $witem) = @_;
	# Get current song information.
	# If you want song details to be displayed
	# directly with the current song:
	# - Uncomment lines: 50/51/56/57/60
        # -* Comment line 59 (Important)
  if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
      my $position = `audtool --playlist-position`;
      my $song = `audtool --current-song`;
      my $current = `audtool --current-song-output-length`;
      my $total = `audtool --current-song-length`;
#      my $bitrate = `audtool --current-song-bitrate-kbps`; #line 50
#      my $frequency = `audtool --current-song-frequency-khz`; #line 51
      chomp($song);
      chomp($position);
      chomp($current);
      chomp($total);
#      chomp($bitrate); #line 56
#      chomp($frequency); #line 57

      $witem->command("/me is listening to: #$position | $song ($current/$total)"); #line 59
# $witem->command("/me is listening to: #$position | $song ($current/$total) [$bitrate kbps/$frequency khz]"); #line 60
   }
    else {
      $witem->print("Audacious is not currently running.");
    }
   return 1;
  }
}

sub cmd_next {
   my ($data, $server, $witem) = @_;
	# Skip to the next track.
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
      my $next = `audtool --playlist-advance`;
	# Uncomment those lines if you want the script to
	# automatically notify the channel to what song you have skipped
#     my $position = `audtool --playlist-position`;
#     my $song = `audtool --current-song`;
#     chomp($position);
#     chomp($song);

      $witem->print("Skipped to next track.");
#     $witem->command("/me has skipped to: #$position $song");
   }
    else {
      $witem->print("Can't skip to next track. Check your Audacious.");
    }
   return 1;
   }
}

sub cmd_previous {
   my ($data, $server, $witem) = @_;
	# Skip to the previous track.
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
      my $reverse = `audtool --playlist-reverse`;
	# Uncomment those lines if you want the script to
	# automatically notify the channel to what song you have skipped
#     my $position = `audtool --playlist-position`;
#     my $song = `audtool --current-song`;
#     chomp($position);
#     chomp($song);

      $witem->print("Skipped to previous track.");
#     $witem->command("/me has skipped to: #$position $song");
   }
    else {
      $witem->print("Can't skip to next track. Check your Audacious.");
    }
   return 1;
   }
}

sub cmd_play {
   my ($data, $server, $witem) = @_;
	# Start playback.
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
      my $play = `audtool --playback-play`;

      $witem->print("Started playback.");
   }
    else {
      $witem->print("Playback can't be performed now.");
    }
   return 1;
   }
}

sub cmd_pause {
   my ($data, $server, $witem) = @_;
	# Pause playback.
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
      my $pause = `audtool --playback-pause`;

      $witem->print("Paused playback.");
   }
    else {
      $witem->print("Pause can be only performed when Audacious is running.");
    }
   return 1;
   }
}

sub cmd_stop {
   my ($data, $server, $witem) = @_;
	# Pause playback.
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
      my $stop = `audtool --playback-stop`;

      $witem->print("Stopped playback.");
   }
    else {
      $witem->print("This way you can't start Audacious.");
    }
   return 1;
   }
}

sub cmd_playlist {
   my ($data, $server, $witem) = @_;
	# Displays entire playlist loaded.
   if (`ps -C audacious` =~ /audacious/) {
    my $display = `audtool --playlist-display`;
    chomp($display);

    Irssi::print("$display");
   }
   else {
    $witem->print("Start your player first.");
    }
   return 1; 
}

sub cmd_shuffle {
   my ($data, $server, $witem) = @_;
	# Turns shuffle on/off
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
     my $shuffle = `audtool --playlist-shuffle-toggle`;
     my $shuffle_status = `audtool --playlist-shuffle-status`;
     chomp($shuffle);
     chomp($shuffle_status);

     if ($shuffle eq "on") {
       $witem->print("Shuffle is now $shuffle_status");
      }
     else {
       $witem->print("Shuffle is now $shuffle_status");
        }
    }
    else {
     $witem->print("Can't perform this action.");
     }
    return 1;
  }
}

sub cmd_repeat {
   my ($data, $server, $witem) = @_;
	# Turns repeat on/off
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
     my $repeat = `audtool --playlist-repeat-toggle`;
     my $repeat_status = `audtool --playlist-repeat-status`;
     chomp($repeat);
     chomp($repeat_status);

     if ($repeat eq "on") {
       $witem->print("Repeat is now $repeat_status");
      }
     else {
       $witem->print("Repeat is now $repeat_status");
        }
    }
    else {
     $witem->print("Can't perform this action.");
     }
    return 1;
  }
}

sub cmd_details {
   my ($data, $server, $witem) = @_;
	# Displays current song's details.
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
     my $bitrate = `audtool --current-song-bitrate-kbps`;
     my $frequency = `audtool --current-song-frequency-khz`;
     my $length = `audtool --current-song-length`;
     my $volume = `audtool --get-volume`;
     chomp($bitrate);
     chomp($frequency);
     chomp($length);
     chomp($volume);

    $witem->print("Current song details: rate: $bitrate kbps - freq: $frequency khz - l: $length min - vol: $volume");
   }
   else {
    $witem->print("Your player doesn't seem to be running");
    }
   return 1;
  }
}

sub cmd_version {
   my ($data, $server, $witem) = @_;
	# Displays version information to the channel.
	# For those who have problems with this
	# try changing `audacious --version` to `audtool -v`
   if ($witem && ($witem->{type} eq "CHANNEL")) {
    if (`ps -C audacious` =~ /audacious/) {
     my $audacious_version = `audacious --version`;
     chop $audacious_version;

     $witem->command("/me is running: Audacious Irssi Script v$VERSION with ".$audacious_version);
    }
    else {
     $witem->command("/me is running: Audacious Irssi Script v$VERSION"); 
     }
    return 1;
  }
}

sub cmd_help {
   my ($data, $server) = @_;
	# Displays usage screen.
      Irssi::print("* /audacious song - Display the current song playing to a channel.");
      Irssi::print("* /audacious next     - Start playback.");
      Irssi::print("* /audacious previous     - Start playback.");
      Irssi::print("* /audacious play     - Start playback.");
      Irssi::print("* /audacious pause    - Pause playback.");
      Irssi::print("* /audacious stop    - Stop playback.");
      Irssi::print("* /audacious playlist    - Displays entire playlist.");
      Irssi::print("* /audacious shuffle    - Turns shuffle on/off.");
      Irssi::print("* /audacious repeat    - Turns repeat on/off.");
      Irssi::print("* /audacious details   - Displays current song's details");
      Irssi::print("* /audacious about  - Displays version of the script and audacious in the channel.");
}

sub cmd_audacious {
   my ($data, $server, $witem) = @_;
    if ($data =~ m/^[(song)|(next)|(previous)|(play)|(pause)|(stop)|(help)|(playlist)|(shuffle)|(repeat)|(details)|(about)]/i) {
      Irssi::command_runsub('audacious', $data, $server, $witem);
   }
    else {
      Irssi::print("Use /audacious <option> or check /help audacious for the complete list");
   }
}

Irssi::command_bind ('audacious song', 'cmd_song');
Irssi::command_bind ('audacious next', 'cmd_next');
Irssi::command_bind ('audacious previous', 'cmd_previous');
Irssi::command_bind ('audacious play', 'cmd_play');
Irssi::command_bind ('audacious pause', 'cmd_pause');
Irssi::command_bind ('audacious stop', 'cmd_stop');
Irssi::command_bind ('audacious help', 'cmd_help');
Irssi::command_bind ('audacious playlist', 'cmd_playlist');
Irssi::command_bind ('audacious shuffle', 'cmd_shuffle');
Irssi::command_bind ('audacious repeat', 'cmd_repeat');
Irssi::command_bind ('audacious details', 'cmd_details');
Irssi::command_bind ('audacious about', 'cmd_version');
Irssi::command_bind ('audacious', 'cmd_audacious');

Irssi::print("Audacious Irssi Script v$VERSION is loaded successfully");