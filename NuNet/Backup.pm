#!/usr/bin/perl -w

use strict;
package NuNet::Backup;

use Term::ANSIColor;
use File::Copy;
use File::Path qw(make_path remove_tree);

our $NumBk = 6; # Number of backups to keep
our $DEBug = 0;
our $BkDir = "/home/Media/Backups/";
		 
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
	
	#move("$SiteBkDir/hourly.2","$SiteBkDir/hourly.3");
	#move("$SiteBkDir/hourly.1","$SiteBkDir/hourly.2");
	#move("$SiteBkDir/hourly.0","$SiteBkDir/hourly.1");
	
	
	#my $output = qx{rsync -h -z -e "ssh -i /home/srainsdon/.ssh/srv1" -a --force --delete-excluded --delete --stats --link-dest=$SiteBkDir/hourly.1/ srv1.247ly.com:/home/Hosting/Sites/$Site/ $SiteBkDir/hourly.0/};
	#warn("rsync failed?") if ($? / 256);
	#my ($sent)     = ($output =~ /Total bytes sent: (\d+)/);
	#my ($received) = ($output =~ /Total bytes received: (\d+)/);
	#print "Totals: Sent $sent Received $received.\n";
	print "DEBUG ON" if $DEBug = 1;
	}
foreach (@Sites) { 
$Site = $_;
$SiteBkDir = $BkDir . $Site;
#print "Checking $SiteBkDir\n";
if (-d $SiteBkDir) {
    print color 'bold Green';
    print "Found Directory for $Site\n";
	print color 'reset';
	MoveFiles($SiteBkDir, $Site);
	
} else {
	#print "Missing Directory for $Site\n"
	print color 'bold Red';
	print "Missing Directory for $Site\n";
	print color 'reset';
	mkdir $SiteBkDir;
}
}

1;