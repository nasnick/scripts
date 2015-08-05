#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purpose: Restart Connector if find an error in the list at the bottom of this script

use File::Basename;

my $strPath = "/var/tmp";
my $strLogFile = $strPath."/mq_error_in_mqtrig_log.log";
my $emailSubject;
my $emailMessage;
  
## Redirect all the output to the logfile
open(STDOUT, '>>',$strLogFile) or die $!;


	
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
        'Reason = 2150'
    );
    return @errorList;  
}

## Get the difference of the log since the last time was checked
sub getDiffLog {
    @difference = `sudo -u root /usr/bin/logtail $strPath/mqtrig.log`;
    chomp @difference;  
    return @difference;  
}

## Receive a message and pre-append the time
sub logMessage {
    my $timestamp = `perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'`;
    chomp($timestamp);
    print $timestamp." ".$_[0]."\n";
}

sub sendEmail {
 my $timestamp = `perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'`;
 $to = 'gpsss.inf@b2be.com,nz.support@b2be.com';
 $from = 'unxappp03';
 $subject = $emailSubject;
 $message = $emailMessage.$timestamp;

  open(MAIL, "|/usr/sbin/sendmail -t");

   # Email Header
   print MAIL "To: $to\n";
   print MAIL "From: $from\n";
   print MAIL "Subject: $subject\n\n";
   # Email Body
   print MAIL $message;

   close(MAIL);
}