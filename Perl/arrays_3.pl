use strict;
use warnings;

#turn off output buffering

	$|=1;

sub main {

	my @files = (
		'/Users/nickschofield/Desktop/IMG_2355.JPG', 
		'/Users/nickschofield/Desktop/Volunteer Application Form 2014.pdf',
		'hi',
		); 

	foreach my $file(@files){	
	if(-f $file){
		print "found file: $file\n";
	}
	else {
		print "file not found: $file\n";
		}
	}
}

main();