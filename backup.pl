#!/usr/bin/perl
use Term::ANSIColor;
use File::Copy;
use File::Path qw(make_path remove_tree);

$NumBk = 3; # Number of backups to keep
$BkDir = "/home/Media/Backups/";


@Sites = ("247ly.com",
         "perlcat.247ly.com",
		 "slayer1of1.pirate",
		 "wip.247ly.com",
		 "reporting.247ly.com",
		 "srv1.247ly.com",
		 "man.247ly.com",
		 "site.247ly.com",
		 "test.247ly.com"
		 ); # Remove "files.247ly.com", because of size until backup is working correctly
		 
		 
sub MoveFiles {
my $SiteBkDir = shift;
my $SiteName = shift;
	print "Prossesing $SiteBkDir.\n";
	remove_tree( "$SiteBkDir/hourly.3");
	move("$SiteBkDir/hourly.2","$SiteBkDir/hourly.3");
	move("$SiteBkDir/hourly.1","$SiteBkDir/hourly.2");
	move("$SiteBkDir/hourly.0","$SiteBkDir/hourly.1");
	my $output = qx{rsync -h -z -e "ssh -i /home/srainsdon/.ssh/srv1" -a --force --delete-excluded --delete --stats --link-dest=$SiteBkDir/hourly.1/ srv1.247ly.com:/home/Hosting/Sites/$Site/ $SiteBkDir/hourly.0/};
	warn("rsync failed?") if ($? / 256);
	my ($sent)     = ($output =~ /Total bytes sent: (\d+)/);
	my ($received) = ($output =~ /Total bytes received: (\d+)/);
	print "Totals: Sent $sent Received $received.\n";
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