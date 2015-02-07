#/usr/lib/nagios/plugins/check_nexus.pl
#symbolic link in /etc/nagios-plugins and  /usr/lib/nagios/plugins?

use XML::Simple;
use Data::Dumper;
use LWP::Simple;

# create object
$xml = new XML::Simple;

use constant {
    OK       => 0,
    WARNING  => 1,
    CRITICAL => 2,
    UNKNOWN  => 3,
};

# read XML file
my $req = get('http://core-archive.build.ecnrtl.com/service/local/status');
$data = $xml->XMLin($req);

# print output
#print $data->{data}->{'state'};


if ( $data->{data}->{'state'} == "STARTED" ) {
    print(
        'OK: Nexus Status: ',
        $data->{data}->{'state'}
        );
        exit OK;
} else {
  print(
        'CRITICAL: Nexus Status: ',
        $data->{data}->{'state'}
        );
        exit CRITICAL;
}
exit OK;