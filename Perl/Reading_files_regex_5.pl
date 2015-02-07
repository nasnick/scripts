use strict;
use warnings;

$|=1;

sub main {
	my $file= "/Users/nickschofield/Desktop/perl/txt.txt";
	
	open(INPUT, $file) or die("nup, no findy findy $file\n");

	while(my $line = <INPUT>) {
		if($line =~ /both/) {
			print $line;
		}
	}
close(INPUT);
}
main(); 	
	