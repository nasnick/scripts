#!/usr/bin/perl -w
# Sergio Aguila
# 15.01.2015
# Purpose: Check if a FS is mounted and mount it as ro using sshfs
use Getopt::Long;

my $result = 0;

GetOptions ("o=s"   => \$strOption,      # string
                       );

my $strRemotePath=$ARGV[0];
my $strMountPoint=$ARGV[1];

if (!isMounted($strMountPoint)) {
        print "Is mounted!!!"."\n";
        umount($strMountPoint)
}

if (!mount($strOption,$strRemotePath,$strMountPoint) ) {
    print "Mounted Successfully"."\n";
    exit 0;

} else {
    print "Could not mount the FS"."\n";
    exit 1;
}

###Sub Routines

sub isMounted {
      my $myPath = $_[0];
      `mountpoint -q $myPath`;
      return $?;
}

sub umount {
      print "Unmounting"."\n";
      my $myPath = $_[0];
      return `umount $myPath`;
}

sub mount {
      print "Mounting"."\n";
      my($strOption,$myRemotePath,$myMountPoint) = @_;
      my $strcommand= "sudo sshfs -o $strOption $myRemotePath $myMountPoint";
      return `$strcommand`;
}

