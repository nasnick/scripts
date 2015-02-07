# use strict;
# use warnings;
# 
# $|=1;
# 
# sub main {
# 	my $file = '/Users/nickschofield/Documents/IT/perl/scripts/txt.txt';
# 	open(INPUT, $file) or die("Input file $file not found.\n");
# 	my $output = 'output.txt';
# 	open(OUTPUT, '>'.$output) or die "Can't create $output.\n";
# 	while(my $line = <INPUT>) {
# 
# 		# Surround the bits you want to "capture" with round brackets
# 		if($line =~ /(s.*?n)/) {
# 		print OUTPUT "$1 \n";
# 
# 		}
# 	}
# 
# 	close(INPUT);
# 	close(OUTPUT);
# }
# main()
# 
# #if($line =~ /(s.*n)/) equals match as much as it can

