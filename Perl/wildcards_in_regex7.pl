use strict;
use warnings;

$|=1;

sub main {
	my $file = '/Users/nickschofield/Documents/IT/perl/scripts/txt.txt';
	
	open(INPUT, $file) or die("Input file $file not found.\n");
	my $output = 'output.txt';
	open(OUTPUT, '>'.$output) or die "Can't create $output.\n";
	while(my $line = <INPUT>) {

		# Surround the bits you want to "capture" with round brackets
		if($line =~ /(I..a.)(...)/) {
			# The stuff matched by the first set of round brackets if now in $1
			# The stuff matched by the second set is in $2
			print OUTPUT "First match: '$1'; second match:'$2'\n";
		}
	}

	close(INPUT);
	close(OUTPUT);
}
main()