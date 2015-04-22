restartconnector.pl 
#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purpose: Restart Connector if find an error in the list at the bottom of this script

use File::Basename;

my $strPath = "/var/log/apache2";
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
	'CHANNEL TERMINATED \[PLUMBINGWORLDdir.to.dir\]'
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


____________________________________________

2014-06-25 15:49:22 Error Found: CHANNEL TERMINATED [PLUMBINGWORLDdir.to.dir]
2014-06-25 15:49:22 Stopping Connector
2014-06-25 15:49:22 System is not running.
2014-06-25 15:49:22 Connector Stopped
2014-06-25 15:49:22 Starting the connector
2014-06-25 16:51:43 Error Found: CHANNEL TERMINATED [PLUMBINGWORLDdir.to.dir]
2014-06-25 16:51:43 Stopping Connector
2014-06-25 16:51:43 System is not running.
2014-06-25 16:51:43 Connector Stopped
2014-06-25 16:51:43 Starting the connector
CHANNEL TERMINATED [PLUMBINGWORLDdir.to.dir]
2014-08-04 09:32:33 Error Found: CHANNEL TERMINATED [PLUMBINGWORLDdir.to.dir]
2014-08-04 09:32:33 Stopping Connector
2014-08-04 09:32:33 System is not running.
2014-08-04 09:32:33 Connector Stopped
2014-08-04 10:11:30 Error Found: CHANNEL TERMINATED [PLUMBINGWORLDdir.to.dir]
2014-08-04 10:11:30 Stopping Connector
2014-08-04 10:11:30 System is not running.
2014-08-04 10:11:30 Connector Stopped
2014-08-04 10:11:30 Before starting
2014-08-04 10:26:10 Error Found: CHANNEL TERMINATED [PLUMBINGWORLDdir.to.dir]
2014-08-04 10:26:10 Stopping Connector
2014-08-04 10:26:10 System is not running.
2014-08-04 10:26:10 Connector Stopped
2014-08-04 10:26:10 Before starting
2014-08-04 10:38:46 Error Found: CHANNEL TERMINATED [PLUMBINGWORLDdir.to.dir]
2014-08-04 10:38:46 Stopping Connector
2014-08-04 10:38:46 System is not running.
2014-08-04 10:38:46 Connector Stopped
2014-08-04 10:38:46 Before starting
2014-08-04 10:38:46 stopping log manager...

2014-08-04 10:38:46 After starting
2014-08-04 10:38:46 Before Checking
2014-08-04 10:38:46 System is not running.
2014-08-04 10:38:46 Could not start Connector
2014-08-04 10:55:12 Error Found: CHANNEL TERMINATED [PLUMBINGWORLDdir.to.dir]
2014-08-04 10:55:12 Stopping Connector
2014-08-04 10:55:12 System is not running.
2014-08-04 10:55:12 Connector Stopped
2014-08-04 10:55:12 Before starting
2014-08-04 10:55:12 0
2014-08-04 10:55:12 After starting
2014-08-04 10:55:12 Before Checking
2014-08-04 10:55:12 System is running.
2014-08-04 10:55:12 Connector Restarted
-bash-2.05b$ ./con_check.sh 
System is running.
