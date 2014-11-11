#!/usr/bin/perl -w
use strict;
use Array::Utils qw(:all);

my $file = "one_addresses";
my $file2 = "two_addresses";
open (FH, "< $file") or die "Can't open $file for read: $!";
my @lines;
while (<FH>) {
    push (@lines, $_);
}
close FH or die "Cannot close $file: $!";


open (FH, "< $file2") or die "Can't open $file2 for read: $!";
my @lines2;
while (<FH>) {
    push (@lines2, $_);
}
close FH or die "Cannot close $file2: $!";

#my @diff = array_diff(@lines, @lines2);
#print @diff

my @minus = array_minus(@lines2, @lines);
#print @minus

my @sorted = sort @minus;
print @sorted


