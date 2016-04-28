#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purpose: Restart Connector if find an error in the list at the bottom of this script

use File::Basename;

my $strPath = "/usr/local/ecnet/Connector";
my $strLogFile = $strPath."/connectorrestarted.log";

open(STDOUT, '>>',$strLogFile) or die $!;


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

## Receive a message and pre-append the time
sub logMessage {
    my $timestamp = `perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'`;
    chomp($timestamp);
    print $timestamp." ".$_[0]."\n";
}

sub getErrorList {
    my @errorList = (
#       Add errors here
     'Reason for failure: Channel'
    );
    return @errorList;  
}


## Get the difference of the log since the last time was checked
sub getDiffLog {
    @difference = `sudo -u root /usr/bin/logtail $strPath/testlogfile`;
    chomp @difference;  
    return @difference;  
}


sub removeFile {
    my @diffLog = getDiffLog();
      while (<$fh>) {
        if ($_ =~ /Reason for failure: Channel/) {
          $line = $_;
          ($file) = $line =~ m/\/(.*),/;
          print '/',$file;
}