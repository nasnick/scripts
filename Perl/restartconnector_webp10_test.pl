#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purpose: Restart Connector if find an error in the list at the bottom of this script

use File::Basename;

my $strPath = "/usr/local/ecnet/Connector";
my $strLogFile = $strPath."/connectorrestarted.log";
my $emailSubject;
my $emailMessage;
  
## Redirect all the output to the logfile
open(STDOUT, '>>',$strLogFile) or die $!;


if (checkLogFile()) {
	## Stop Connector
	if (! stopConnector()) {	 # Pass the check if the connector stopped successfully
	    ## Start Connector
	    logMessage("Connector Stopped");
	    if (! startConnector()) {    # Pass the check if the connector started successfully
		logMessage("Connector Restarted");
                $emailSubject = "Connector restarted on unxcoms01"; 
                $emailMessage = "Connector on unxcoms01 was restarted at ";
                sendEmail();
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
#       Add errors here
     'Reason for failure: Channel'
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

sub removeFile {
    my @diffLog = getDiffLog();
      while (<$fh>) {
        if ($_ =~ /Reason for failure: Channel/) {
          $line = $_;
          ($file) = $line =~ m/\/(.*),/;
          print '/',$file;
}

sub sendEmail {
 my $timestamp = `perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'`;
 $to = 'gpsss.inf@b2be.com,nz.support@b2be.com';
 $from = 'unxcoms01';
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




*****************************************************************************

CHANNEL TERMINATED [TWL.TEST2.INCOMING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Channel [TWL.TEST2.INCOMING]: action failed while processing message [src-file:/var/tmp/portal/twl_test2/testing-107316.xml,output-file:/usr/local/ecnet/Connector/messages/inbox/twl_test2/twl-test2-order-20160322-1022020480.in]
: App [twl_test2.sh] returned error status [255].

*****************************************************************************
*****************************************************************************

CHANNEL TERMINATED [TWL.TEST.INCOMING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Channel [TWL.TEST.INCOMING]: action failed while processing message [src-file:/var/tmp/portal/twl_test/TWL_ISSUES.txt,output-file:/usr/local/ecnet/Connector/messages/inbox/twl_test/twl-test-order-20151223-0901210539.in]
: App [twl_test.sh] returned error status [255].

*****************************************************************************
*****************************************************************************

CHANNEL TERMINATED [TWG.UAT.INCOMING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Channel [TWG.UAT.INCOMING]: action failed while processing message [src-file:/var/tmp/portal/twg/reponotbeingseenintheportalb2be18470097(1).zip,output-file:/usr/local/ecnet/Connector/messages/inbox/twg/twg-test-order-20151117-1122580327.in]
: App [twg.sh] returned error status [255].

*****************************************************************************
*****************************************************************************

CHANNEL TERMINATED [TWG.UAT.INCOMING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Channel [TWG.UAT.INCOMING]: action failed while processing message [src-file:/var/tmp/portal/twg/reponotbeingseenintheportalb2be18470097(1).zip,output-file:/usr/local/ecnet/Connector/messages/inbox/twg/twg-test-order-20151117-1124140340.in]
: App [twg.sh] returned error status [255].

*****************************************************************************
*****************************************************************************

CHANNEL TERMINATED [TWL.TEST2.INCOMING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Channel [TWL.TEST2.INCOMING]: action failed while processing message [src-file:/var/tmp/portal/twl_test2/TWL_LargeFID_PO_TEST2.xml,output-file:/usr/local/ecnet/Connector/messages/inbox/twl_test2/twl-test2-order-20151130-1158220333.in]
: App [twl_test2.sh] returned error status [255].

*****************************************************************************
*****************************************************************************

CHANNEL TERMINATED [TWG.UAT.INCOMING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Channel [TWG.UAT.INCOMING]: action failed while processing message [src-file:/var/tmp/portal/twg/reponotbeingseenintheportalb2be18470097(1).zip,output-file:/usr/local/ecnet/Connector/messages/inbox/twg/twg-test-order-20151117-1122580327.in]
: App [twg.sh] returned error status [255].

*****************************************************************************
*****************************************************************************

CHANNEL TERMINATED [NLG.UAT.OUTGOING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Reader failed: failed to archive file [/var/www/htdocs/nlg/output/inv20150708.1005251088.xml] as [/usr/local/ecnet/Connector/messages/outbox-archive/nlg/inv20150708.1005251088.xml] (unknown reason... are the source and destination files on the same filesystem? are permissions correct?)

*****************************************************************************
*****************************************************************************

CHANNEL TERMINATED [TWL.TEST2.INCOMING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Channel [TWL.TEST2.INCOMING]: action failed while processing message [src-file:/var/tmp/portal/twl_test2/SSJ00315117.FIS_Test_ORDER_1264_01.xml,output-file:/usr/local/ecnet/Connector/messages/inbox/twl_test2/twl-test2-order-20150710-0934400888.in]
: App [twl_test2.sh] returned error status [255].

*****************************************************************************
*****************************************************************************

CHANNEL TERMINATED [TWL.TEST2.INCOMING]

This channel has stopped processing messages, the program must be RESTARTED.

Reason for failure: Channel [TWL.TEST2.INCOMING]: action failed while processing message [src-file:/var/tmp/portal/twl_test2/SSJ00315117.FIS_Test_ORDER_1264_01.xml,output-file:/usr/local/ecnet/Connector/messages/inbox/twl_test2/twl-test2-order-20150710-0941280322.in]
: App [twl_test2.sh] returned error status [255].

*****************************************************************************

RTL-8.1.0_GA





