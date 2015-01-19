#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purpose: Restart Connector if find an error in the list at the bottom of this script

use File::Basename;
use MIME::Lite;

my $strPath = "/usr/local/ecnet/Connector";
my $strLogFile = $strPath."/connectorrestarted.log";

## Redirect all the output to the logfile
open(STDOUT, '>>',$strLogFile) or die $!;


if (checkLogFile()) {
	## Stop Connector
	if (! stopConnector()) {	 # Pass the check if the connector stopped successfully
	    ## Start Connector
	    logMessage("Connector Stopped");
	    if (! startConnector()) {    # Pass the check if the connector started successfully
		logMessage("Connector Restarted");
		exit 0;
	    } else {
		logMessage("Could not start Connector");
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

	
sub stopConnector {
    my $strCheck;
    my $count = 0;
    logMessage("Stopping Connector");
    do {
	`$strPath/con_stop.sh`;
	sleep 5;
	$strCheck = `$strPath/con_check.sh`;
	chomp($strCheck);
	$count++;
	logMessage($strCheck);
    } until ($strCheck =~ /not\ running/ || $count == 5); ## Until the connector has stopped or tried 5 times
    if ($strCheck =~ /not\ running/) {
	return 0;
    } else {
	return 1; ## Exit due to the max attempts to stop
    }
}

sub startConnector {  
    my $strCheck;  
    my $count = 0;
    logMessage("Before starting");
    logMessage(system("$strPath/con_start.sh"));
    logMessage("After starting");
    sleep 5;
    logMessage("Before Checking");
    $strCheck = `$strPath/con_check.sh`;
    chomp($strCheck);
    logMessage($strCheck);
    if ($strCheck =~ /is\ running/) {
	return 0;
    } else {
	return 1;
    }
}

## Add the errors to this list
sub getErrorList {
    my @errorList = (
	'CHANNEL TERMINATED \[PLUMBINGWORLDdir.to.dir\]',
	'CHANNEL TERMINATED \[UNIDEN_WSL_PRODdir.to.MQ\]'
#       Add errors here
#	,'CHANNEL NEED TO BE RESTARTED',
#	'Disconnecting from qmgr \[null\]',
#	'Successfully put message onto queue: PROD.SSJ.CROXLEY'
    );
    return @errorList;  
}

## Get the difference of the log since the last time was checked
sub getDiffLog {
    @difference = `sudo -u root /usr/bin/logtail $strPath/logfile.log`;
    chomp @difference;  
    return @difference;  
}

## Receive a message and pre-append the time
sub logMessage {
    my $timestamp = `perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'`;
    chomp($timestamp);
    print $timestamp." ".$_[0]."\n";
}


 
sub sendMessage {
    $to = 'nz.unix@p.b2be.com';
    $cc = 'gpsss.inf@b2be.com';
    $from = 'root@unxcoms01.ecngroup.co.nz';
    $subject = 'Connector Restarted';
    $message = 'The connector has been restarted by restartconnector.pl';

    $msg = MIME::Lite->new(
                 From     => $from,
                 To       => $to,
                 Cc       => $cc,
                 Subject  => $subject,
                 Data     => $logMessage
                 );
                 
$msg->send;
}
