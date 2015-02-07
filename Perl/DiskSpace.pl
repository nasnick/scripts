#!/bin/bash/perl
use warnings;

$LIMIT=50;

@names=`cat /etc/passwd | cut -f 1 -d :`;
@ids = `cat /etc/passwd | cut -f 3 -d :`;

$length = @ids;
$i = 0;

chomp @names;
chomp @ids;

while($i < $length){
    if( ($ids[$i] >= 1000) && ($ids[$i] <= 1200) ){
       &find_disk_usage($names[$i]); 
    }
   $i+=1;
} 

sub find_disk_usage
{
    $usage=`du -s /home/$_[0] | cut -f 1`;
    chomp $usage;
    if($usage > $LIMIT) {
    print "$_[0] is over the limit. $_[0] is using $usage kilobytes.\n"
   }
} 

