


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


sub removeFile {
    my @diffLog = getDiffLog();
      while (<$fh>) {
        if ($_ =~ /Reason for failure: Channel/) {
          $line = $_;
          ($file) = $line =~ m/\/(.*),/;
          print '/',$file;
}