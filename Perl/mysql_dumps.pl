#!/usr/bin/perl -w
# Sergio Aguila
# 9.6.2014
# Purposes:
# Perform a mysqldump on all the databases specified in the mysql_bak.config file
# Perform a mysqldump of the Full Database 
# Compare the list of databases of the file myslq_bak.config with the list in the mysql db

use warnings;
use File::Basename;
use Array::Utils qw(:all);
use Cwd;

# Variables
my $backup_folder = '/var/local/backups/mysql';
my $config_file = cwd() . "/mysql_bak.config";
my $ErrorFlag = 0;

# Retrieve a list of the databases from the config file
my @databases = removeComments(getFileContents($config_file));

# Change to the directory of the backup files.
chdir($backup_folder) or die("Cannot go to folder '$backup_folder'");
# Grab the local time variables

# Create the name of the backup folder that will contain all of the backup files

my $BackupDir = getBackupDir();
# Name of the file containing the full backup of all the databases
my $BackupAllFile = "backupall-$BackupDir";
$BackupAllFile .= ".sql";

mkdir($BackupDir) or die("Cannot create a folder called '$BackupDir'");
open(STDOUT, '>',$BackupDir."/BackupResult.log") or die $!;

# Backup each database contained in the @databases array in different files
print "Starting Backup... Time: ".getBackupDir()."\n\n";
foreach my $database (@databases) {
    next if ($database eq '');
    chomp($database);

    # you may comment out this print statement if you don't want to see this information
    print "Backing up $database ... ";

    my $file = $database;
    $file .= ".sql";

    # perform a mysqldump on each database
    # change the path of mysqldump to match your system's location
    # make sure that you change the root password to match the correct password
    `/usr/bin/mysqldump -u root -h 127.0.0.1 --password=xxx $database > $BackupDir/$file 2>>$BackupDir/IndividualBackups.err`;
    # you may comment out this print statement if you don't want to see this information
    if (!$?) {
	print $database . " Success\n";
    } else {
	print $database . " Mysqldump encountered a problem look in IndividualBackups.err for information\n";
	$ErrorFlag = 1;
    }
    
}
print "Done Individual backups\n\n";

# Dumps a full backup in a single file
print "Full Backup\n\n";

`/usr/bin/mysqldump --opt --all-databases -u root -h 127.0.0.1 --password=xxx > $BackupDir/$BackupAllFile 2>$BackupDir/FullBackup.err`;

if (!$?) {
    print "Full Backup: " . " Success\n";
    } else {
    print "Full Backup ... Mysqldump encountered a problem look in FullBackup.err for information\n";
    $ErrorFlag = 1;
}


# Compare the databases in the mysql DB with the ones in the file
print "Checking the list of Backups ...\n";

my @difference = checkbackuplist();
if(@difference) {
    print "The list of Databases is not Updated, Difference: " . "\n" . "@difference"; 
    $ErrorFlag = 1;
} else {
    print "List of Databases is updated\n";
};


## Check if were at least one error in all the process and print the result
if(!$ErrorFlag) {
    print "Result: SUCCESS";
    exit 0;
} else {
    print "Result: FAILURE";
    exit 1;
}

#################
## Sub routines #
#################

# This subroutine simply creates an array of the list of the databases
sub getFileContents {
    my $file = shift;
    open (FILE,$file) || die("Can't open '$file': $!");
    my @lines=<FILE>;
    close(FILE);
    return @lines;
}

# Remove any commented tables from the @lines array
sub removeComments {
    my @lines = @_;
    @cleaned = grep(!/^\s*#/, @lines); #Remove Comments
    @cleaned = grep(!/^\s*$/, @cleaned); #Remove Empty lines
return @cleaned;
}

# Compares the list of databases in the server with the list of databases configured in the file mysql_bak.config. They should be the same. Otherwise we are not backing up a DB or one has been deleted.
sub checkbackuplist {
    my @DatabaseListFromDB = getDatabasesListFromDB();
    my @DatabaseListFromFile = getFileContents($config_file);
    my @diff = array_diff(@DatabaseListFromFile, @DatabaseListFromDB);
    return @diff;
}

## Read the list of databases in the mysql database, it is used to compare it with the content of the mysql_bak.config
sub getDatabasesListFromDB {
    my @listdatabases;
    @listdatabases= `/usr/bin/mysql -u root -h 127.0.0.1 --password=xxx -e 'show databases'| grep -v Database | grep -v information_schema | grep -v performance_schema`;
    return @listdatabases;
}

## Get the name of the Directory where the backups are going to be stored
sub getBackupDir {
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
    $year += 1900;
    $mon++;
    # Zero padding
    $mday = '0'.$mday if ($mday<10);
    $mon = '0'.$mon if ($mon<10);

    $hour = "0$hour" if $hour < 10;
    $min = "0$min" if $min < 10;
    
    my $folder = "$year-$mon-$mday-$hour$min";
    
    return $folder;
}
