#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purpose: Restart Connector if find an error in the list at the bottom of this script

use File::Basename;

my $strPath = "/home/nick/scripts/Perl";
my $strLogFile = $strPath."/webservicesrestarted.log";

## Redirect all the output to the logfile
open(STDOUT, '>>',$strLogFile) or die $!;

if (checkLogFile()) {
  logMessage("Error Found");
}
	
	
###############
## Subroutines#
###############
	
sub checkLogFile {
    my $strError;
    my @errorList = getErrorList();
    my @diffLog = getDiffLog();
  
    # Check the list of errors in the list and compare them with the logfile  
    foreach my $errorline (@errorList) {
	foreach my $logline (@diffLog) {
	    if ($logline =~ /$errorline/) {
		logMessage("Error Found: ".$logline);
		return 1;
	    }
	}  
    }
    # If we didn't return anything in the previous loop, means no errors found 
    return 0;    
}



## Add the errors to this list
sub getErrorList {
    my @errorList = (
	'Connection refused: proxy: HTTP: attempt to connect to 127.0.0.1:8080'
#       Add errors here
#	,'CHANNEL NEED TO BE RESTARTED',
#	'Disconnecting from qmgr \[null\]',
#	'Successfully put message onto queue: PROD.SSJ.CROXLEY'
    );
    return @errorList;  
}

## Get the difference of the log since the last time was checked
sub getDiffLog {
    @difference = `sudo -u root /usr/sbin/logtail $strPath/robinsons_error.log`;
    chomp @difference;  
    return @difference;  
}

## Receive a message and pre-append the time
sub logMessage {
    my $timestamp = `perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'`;
    chomp($timestamp);
    print $timestamp." ".$_[0]."\n";
}
