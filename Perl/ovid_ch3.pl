#!/usr/bin/perl
#use strict;
#use warnings;

my @array = qw(a b c);

for my $element (@array){
print "$element\n";
}

my %people = (
	"Tan",   "Thai",
	"Nick",  "NZ",
	"Roger", "Who Knows?",
);
print "$people{'Tan'}\n";

#assign some people to hash
%people = ( %people, john =>'doe', rodders=>'open');

#iterate over hash
for my $name ( keys %people ) {
	print "$name is $people{$name}\n";
}

#fat comma qoutes to the left
my %people_comma = (
        Tan    =>  'Thai',
        Nick   =>  'NZ',
        Roger  =>  'Who Knows?',
	Somsak =>  'Thai'
);
#my $a ="0"; how to do?
my @somtum_lovers = @people_comma{'Tan', 'Somsak'};
for my $lovers ( @somtum_lovers ){
#	my $a += 1;
}
#print $a

print "Som tum lovers are @somtum_lovers[0]\n";

my @people = ('willy', 'alison', 'brent'); 
my @colenso_store = @people[0,1];
for my $name ( @colenso_store ){
	print "$name\n";
}

#scalar context - $things will become 3
my $things = @people;
print "There are $things things\n";

#prints 3
my @things_i_love =( 'cats', 'tan', 'som tum' );
my $number = @things_i_love;
print "here: $number\n";

#scalar context enforced so what's below will be 3
my %count_for = ( useless_things => scalar @things_i_love );
print "$count_for{useless_things}\n";

#commas use list context. scalar context not enforced by using 'scalar' so the result is 'cat'
my %count_for = ( useless_things => @things_i_love );
print "$count_for{useless_things}\n";

#prints cats
my $things_i_love = ( 'cats', 'tan', 'som tum' );
print "$things_i_love\n";

#prints em all 
my @thing_i_love = ( 'cats', 'tan', 'som tum' );
print "@thing_i_love\n";

my $three = @thing_i_love;
print "$three\n";



