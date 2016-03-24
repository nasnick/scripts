#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purpose: Restart Connector if find an error in the list at the bottom of this script

use File::Basename;
use File::Copy;

my $strPath = "/usr/local/ecnet/Connector";
my $strLogFile = $strPath."/connectorrestarted.log";
my $failedFiles = $strPath."/FailedFiles";
our $strError;
our $message;
our $fullfile;

open(STDOUT, '>>',$strLogFile) or die $!;

if (checkLogFile()) {
  ## Stop Connector
  if (! stopConnector()) {   # Pass the check if the connector stopped successfully
      ## Start Connector
      removeFile();
      logMessage("Connector Stopped");
      if (! startConnector()) {    # Pass the check if the connector started successfully
    logMessage("Connector Restarted");
    exit 0;
      } else {
    logMessage("Could not start Connector");
                $emailSubject = "Connector NOT restarted on unxcoms01";
                $emailMessage = "Connector on unxcoms01 was NOT restarted. Escalate to INF team immediately. Timestamp: ";
                sendEmail();
    exit 1;
      }
  } else {
      logMessage("Could not stop Connector"); ## Must print error message.
      exit 1;
  }
} 
  
###############
## Subroutines#
###############

sub checkLogFile {
    my @errorList = getErrorList();
    my @diffLog = getDiffLog();
  
    # Check the list of errors in the list and compare them with the logfile  
    foreach my $errorline (@errorList) {
	foreach my $logline (@diffLog) {
	    if ($logline =~ /$errorline/) {
		our $strError = $logline;
		print STDOUT $strError;
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
    #print $timestamp." ".$_[0]."\n";
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
    @difference = `sudo -u root /usr/sbin/logtail $strPath/testlogfile`;
    chomp @difference;  
    return @difference;  
}

sub removeFile {
  my $line = $strError;
  ($file) = $line =~ m/\/(.*),/;
  $fullfile = '/' . $file;
  $message = `cat $fullfile`;
  sendEmail(); 
  move($fullfile, $failedFiles);
}

sub sendEmail {
 my $timestamp = `perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'`;
 $to = 'nick.schofield@b2be.com';
 $from = 'unxwebp10.ecnetwork.co.nz';
 $subject = 'Contents of:'.$fullfile;
 #$message = $emailMessage.$timestamp;

  open(MAIL, "|/usr/sbin/sendmail -t");

   # Email Header
   print MAIL "To: $to\n";
   print MAIL "From: $from\n";
   print MAIL "Subject: $subject\n\n";
   #Email Body
   print MAIL $message;
   close(MAIL);
}
