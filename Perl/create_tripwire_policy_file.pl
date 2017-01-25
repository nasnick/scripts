#!/usr/bin/perl -w
#  twpolclean.pl
#  Author Bret Hughes  bhughes elevating com

# Use as you will but without guarantee or warranty :)

#  This script is designed to take the default redhat tripwire policy
#  file that contains everything and comment out those files that do
#  not exist on the machine.  As the the twpol.txt file says in its 
#  comments, it is designed for an everything install and can be a 
#  pain to clean up enough to run on a system that does not have
#  everything.

#  What this script does is read the tripwire pol.txt file and for each 
#  line that looks like a file name, see if the file exists on the 
#  system.  
#  If it does not, comment it out.  All other lines get written to the 
#  outfile unchanged


#  copy to /etc/tripwire/twpol.txt ( don't forget to back up the old
#  one first) and you should be good to go with the tw installation

use strict;
# change the vars twpolfile and newtwpolfile to fit your configuration
my $twpolfile = "/etc/tripwire/twpol.txt";
my $newtwpolfile = "/root/new.twpol.txt";

open (POL, "<$twpolfile") or die " could not open file $!\n";
open (NEWPOL, ">$newtwpolfile") or die "could not open file \n";

foreach my $line (<POL>){
    
    if ($line =~ /^\s*\/.*/){
# this is a file name lets look and see if it exists
	my ($file, $rest) = split " ", $line;

# uncomment the print statements if you want to see what files are
# processed 
#	print "file name portion is $file\n"; 
	if (! -e $file){
#	    print "*******  file does not exist $file \n";
	    $line = "#$line";
	}
    }
    
    print NEWPOL $line;
}
close POL;
close NEWPOL;
