#!/usr/bin/perl

my @dirlst_excluded = (                       ## amend this list if necessary, ABSOLUTE PATH
q{/usr/local/ecnet/ssj/current/pfizer_gtins-in},
q{/usr/local/ecnet/ssj/current/pfizer_pind_portal_entereditems-in},
q{/usr/local/ecnet/ssj/current/pfizer_EOM_Dates-in},
q{/usr/local/ecnet/ssj/current/pah_pind_portal_entereditems-in},
q{/usr/local/ecnet/ssj/current/pah_EOM_Dates-in},
q{/usr/local/ecnet/ssj/current/planetfun-in},
);

foreach (@dirlst_excluded) {
  print "$_\n";
}


sub logMessage {
    my $timestamp = `perl -MPOSIX -le 'print strftime "%F %T", localtime $^T'`;
    chomp($timestamp);
    print $timestamp." ".$_[0]."\n";
}
logMessage();

sub myNegativeFunction {
  return 1;
}

sub myPositiveFunction {
  return 0;
}

sub printNegative {
 print "Yep it returned a 1.\n"
}

sub printPositive {
  print "yep it returned a 0.\n"
}

if (myNegativeFunction()) {
  if (! printNegative()) {
  }
 }

if (myPositiveFunction() == true) {
     printPositive();
     print "hello there";
}
