#!/usr/bin/perl
strict
use NuNet::Backup
$BkDir = "/home/Media/Backups/";
$RsyncOpt = "-h -z -e \"ssh -i /home/srainsdon/.ssh/srv1\" -a --force --delete-excluded --delete --stats";
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