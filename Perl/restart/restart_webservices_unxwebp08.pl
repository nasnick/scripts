#!/usr/bin/perl -w
# 01.05.2015
# Purpose: Restart Web services on unxwebp08 if there is an issue with the Robinsons portal

use File::Basename;

my $strPath = "/opt/robinsons";
my $strPathScript = $strPath."/bin";
my $strScriptLogFile = $strPath."/webservices_restarted.log";
my $strApacheLogFile = "/var/log/apache2/robinsons_error.log";

## Redirect all the output to the logfile
open(STDOUT, '>>',$strScriptLogFile) or die $!;


if (checkLogFile()) {
	##restart webservices if error found 
	if (! restartWebServices()) {
           logMessage("Web services restarting");
           exit 0;
	} else {
	    logMessage("Could not restart webservices."); ## Must print error message.
	    exit 1;
	}
}	
	
###############
## Subroutines#
###############
  
sub restartWebServices {
    my $webservices;
    
    do {
         $webservices = `$strPathScript/restartRobinsonsTomcat_new.sh`;
         chomp($webservices);
	 return 0;
      }
}
	
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
    );
    return @errorList;  
}

## Get the difference of the log since the last time was checked
sub getDiffLog {
    @difference = `/usr/sbin/logtail $strApacheLogFile`;
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
 $to = 'nick.schofield@b2be.com';
 $from = 'webmaster@yourdomain.com';
 $subject = 'Test Email';
 $message = 'Web services were restarted on webp08';
  
  open(MAIL, "|/usr/sbin/sendmail -t");
   
   # Email Header
   print MAIL "To: $to\n";
   print MAIL "From: $from\n";
   print MAIL "Subject: $subject\n\n";
   # Email Body
   print MAIL $message;

   close(MAIL);
}
