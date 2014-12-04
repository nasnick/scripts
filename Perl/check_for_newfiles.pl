#!/usr/bin/perl -w
use strict;

AscertainStatus();

sub AscertainStatus {
        my $DIR = "test2";
        opendir(HAN1, "$DIR") || die "Problem: $1";
        my @array1 = readdir(HAN1);
        if("$#array1" > 1) {
#get rid of the . and .. directory from the array with the following
                for (my $i=0; $i<2;  $i++) {shift @array1;}
                MailNewFiles(@array1);
        } else {  print "No new files!\n"; }
}

sub MailNewFiles {
use Mail::Mailer;
my $from = "root";
my $to = "root@";
my $subject = "New Files";
my $mailer = Mail::Mailer->new();
        $mailer->open({from=> $from,
                        To=> $to,
                        Subject => $subject,
                        });

my $header = " New Files";
print $mailer $#_+ 1;
print $mailer "$header\n";
foreach (@_) { print $mailer "$_\n";}
}


