#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purpose: Restart Connector if find an error in the list at the bottom of this script

use File::Basename;
use File::Copy;
use MIME::Lite;

my $strPath = "/usr/local/ecnet/Connector";
my $strLogFile = $strPath."/connectorrestarted.log";
my $failedFiles = $strPath."/FailedFiles";
our $strError;
our $message;
our $emailSubject;
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
                $emailSubject = "Connector ***NOT*** restarted on unxwebp10";
                $emailMessage = "Connector on unxcoms01 was NOT restarted. Escalate to INF team immediately. Timestamp: ";
                sendEmail();
    exit 1;
      }
  } else {
      logMessage("Could not stop Connector"); ## Must print error message.
      exit 1;
  }
} 
 
##############
# Subroutines#
##############

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
    `$strPath/con_start.sh`;
    logMessage("After starting");
    sleep 5;
    logMessage("Before Checking");
    $strCheck = `$strPath/con_check.sh`;
    chomp($strCheck);
    logMessage($strCheck);
    if ($strCheck =~ /Connector\ running/) {
  return 0;
    } else {
  return 1;
    }
}

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
    @difference = `sudo -u root /usr/sbin/logtail $strPath/logfile.log`;
    chomp @difference;  
    return @difference;  
}

sub removeFile {
  my $line = $strError;
  ($file) = $line =~ m/\/(.*),/;
  $fullfile = '/'.$file;
  chomp($fullfile);
  #Set
  $emailSubject = 'Connector restarted on unxwebp10. Failed file ('.$fullfile.')attached';
  #$emailMessage = `cat $fullfile`;
  sendEmail(); 
  move($fullfile, $failedFiles);
}

sub sendEmail {
  my $msg = MIME::Lite->new(
      From    => 'unxwebp10',
      To      => 'nick.schofield@b2be.com,nzconsulting.support@b2be.com',
      Subject => $emailSubject,
      Type    => 'multipart/mixed',
  );

  $msg->attach(
      Type     => 'TEXT',
      Data     => 'Contents of failed file from unxwebp10'.$fullfile,
  );

  $msg->attach(
      Type     => 'TEXT',
      Path     => $fullfile,
      Filename => $fullfile,
  );

  $msg->send;
}
