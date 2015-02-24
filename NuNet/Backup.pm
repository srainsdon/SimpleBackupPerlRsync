#!/usr/bin/perl -w

use strict;
package NuNet::Backup;

use Term::ANSIColor;
use File::Copy;
use File::Path qw(make_path remove_tree);

our $NumBk; # Number of backups to keep
our $DEBug;	# Are we in Debug mode : does not move anything, delete anything or run the rsync command
our $BkDir; # What directory are we backing up to
our $SourceUser; # User name to use to connect to server
our $SourceServer; # Where server are we rsyncing from
our $SourceDir; # What directory is the source in
our $RsyncOpt; # Extra rsync options

sub new {
	
}

sub MoveFiles {
my $SiteBkDir = shift;
my $SiteName = shift;
	print "Prossesing $SiteBkDir.\n";
	my $CurrentBackup = $NumBk;
	print "remove_tree( \"$SiteBkDir/hourly.$CurrentBackup\")";
	while( $CurrentBackup > 0 ){
		printf "Value of CurrentBackup: $CurrentBackup\n";
		my $Next = $CurrentBackup - 1;
		print "move(\"$SiteBkDir/hourly.$Next\",\"$SiteBkDir/hourly.$CurrentBackup\")\n";
		$CurrentBackup = $CurrentBackup - 1;
	}	
	print "rsync $RsyncOpt --link-dest=$SiteBkDir/hourly.1/ $SourceUser\@$SourceServer:$SourceDir $SiteBkDir/hourly.0/";
	#move("$SiteBkDir/hourly.2","$SiteBkDir/hourly.3");
	#move("$SiteBkDir/hourly.1","$SiteBkDir/hourly.2");
	#move("$SiteBkDir/hourly.0","$SiteBkDir/hourly.1");
	
	
	#my $output = qx{rsync $RsyncOpt --link-dest=$SiteBkDir/hourly.1/ $SourceUser\@$SourceServer:$SourceDir $SiteBkDir/hourly.0/};
	#warn("rsync failed?") if ($? / 256);
	#my ($sent)     = ($output =~ /Total bytes sent: (\d+)/);
	#my ($received) = ($output =~ /Total bytes received: (\d+)/);
	#print "Totals: Sent $sent Received $received.\n";
	print "DEBUG ON" if $DEBug = 1;
	}

1;