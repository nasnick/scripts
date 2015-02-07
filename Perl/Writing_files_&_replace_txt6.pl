use strict;
use warnings;

$|=1;


sub main {
	my $input= "/Users/nickschofield/Documents/IT/perl/scripts/txt.txt";
	open(INPUT, $input) or die("nup, no findy findy $input\n");
	my $output = 'output.txt';
	open(OUTPUT, '>'.$output) or die "Can't create $output.\n";
	
	while(my $line = <INPUT>) {
	
	#i = case insensitve, g = global
	
		if($line =~ /\bWales\b/) {
		   $line =~ s/ the / Ronaldo /gi;
			print OUTPUT $line;
		}
	}
	close(OUTPUT);
	close(INPUT);

}

main();


# '.' concatenates the symbol to $output. Could be: my $output = '>output.txt';
#my $usage = `ls -l`;
#print OUTPUT $usage;

#!/bin/bash/perl
use warnings;

my @array = `cat /etc/passwd | cut -f 1 -D:`;

print arg ( @array );

sub arg {
	my {$1, $2} = @_;
	print $2;

}

