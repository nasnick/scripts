#!/usr/bin/perl -w
# Sergio Aguila
# 21.11.2014
# Purposes:
# Check snapshots backups (size, date, location)
# 

use warnings;
use File::Basename;
use Array::Utils qw(:all);
use Cwd;
use Cwd 'abs_path';
use Path::Class qw( file );
use Getopt::Long;
use Switch;


#my $file =  './BackupsAges-sumarized.csv';

GetOptions ("r=s"   => \$strReportType,      # string
                      "f=s"  => \$strBackupList,
                      "l=s"  => \$strLocation
		      );

if ($strBackupList eq "" || $strReportType eq "") {
	print "Ussage: -r <nagios>|<rundeck> -f <Backupfilelist> -l <onsite>|<offsite> ";
	exit 1;
}

my $strCwd = dirname($0);

$strBackupList = $strCwd."/".$strBackupList;

my @lines = getFileContents($strBackupList);
my $strMessageWarning = "";
my $strMessageOK = "";
my $intExitCode = 0;
foreach my $line (@lines) {

    next if ($line eq '');
    chomp($line);
    my @server = split ",", $line;
    my $strBackupDirOffsite = $server[2]."/".$server[0];
    my $strBackupDirOnsite = $server[4]."/".$server[0];
    my $intBackupOffsiteAge = $server[3]*24;
    my $intBackupOnsiteAge = $server[5]*24;
    my $strHost = $server[0];
    my $intBackupSize = $server[6]*1024;
    my $result;
    my $strMessage = '';
    my $strSizeWarning = '';
    my $strBackupFileOnsite = `find "$strBackupDirOnsite" -type f -name *flat.vmdk -printf '%s %p\n'| sort -nr | awk '{print \$2}' | head -1`;
    chomp($strBackupFileOnsite);
    switch ($strLocation) {
	
	case "onsite" {
		if($intBackupOnsiteAge > 0) {
			$strMessage = checkBackup($strBackupFileOnsite, $intBackupOnsiteAge, $intBackupSize,$strHost);
		}
	}
	case "offsite" {
		if($intBackupOffsiteAge > 0) {
    			my $strBackupFileOffsite = `find "$strBackupDirOffsite" -type f -name *flat.vmdk -printf '%s %p\n'| sort -nr | awk '{print \$2}' | head -1`;
    			chomp($strBackupFileOffsite);
	        	$strSizeWarning = compareSnapshotSize($strBackupFileOffsite, $strBackupFileOnsite);	
			if ($strSizeWarning eq '') {$strMessage = checkBackup($strBackupFileOffsite, $intBackupOffsiteAge, $intBackupSize,$strHost)}
			else {
				$intExitCode = 2;
				$strMessage = $strSizeWarning;
			};
		}		
	}
    }
    if ($? || $strSizeWarning ne '') {
	 $strMessageWarning = $strMessageWarning." ".$strMessage;
	 $intExitCode = 2;
    }else {
	$strMessageOK = $strMessageOK." ".$strMessage;
    }
}


if ($strReportType eq "nagios") {
	if ($intExitCode) {
	        print $strMessageWarning;
       		exit $intExitCode;
	}		
	print "SNAPSHOTS OK"."\n";
	exit $intExitCode;
}

if ($strReportType eq "rundeck") {
	print $strMessageWarning."\n".$strMessageOK;
	exit $intExitCode;
}


#################
## Sub routines #
#################

sub checkBackup  {
	my ($strBackupName, $intBackupAge, $intBackupSize, $strHost) = @_;
	my $strdirname = dirname($strBackupName); 
        #Check if the directory contains a file with the extension .ok, if not it retuns an error message	
	if (`ls $strdirname | grep .ok | wc -l` < 1 and `ls $strdirname/../ | grep .ok | wc -l` < 1 ) {
	        $? = 1;	
		return "Backup $strBackupName was not successfull"."\n"; 
	} 
	return `$strCwd/snapshot.pl -f $strBackupName -a $intBackupAge -s $intBackupSize: -h $strHost`." Location: ".$strBackupName."\n";
}


sub getFileContents {
    open (FILE,$strBackupList) || die("Can't open '$strBackupList': $!");
    my @lines=<FILE>;
    close(FILE);
    shift @lines;
    return @lines;
}

sub compareSnapshotSize {
    #print $_[0],$_[1];
    if (-s $_[0] != -s $_[1]) {
	return "Size of $_[0] is different to $_[1]"."\n";	
    }else {
	return '';
    }
}