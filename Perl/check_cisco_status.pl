#!/usr/bin/perl
#check_cisco_status.pl v1.1 checks status of a cisco device
#Copyright (C) 2011  Julian De Marchi (jdemarchi@iseek.com.au)
#
#This program is free software; you can redistribute it and/or
#modify it under the terms of the GNU General Public License
#as published by the Free Software Foundation; either version 2
#of the License, or (at your option) any later version.
#
#This program is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with this program; if not, write to the Free Software
#Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

use strict;
use Net::SNMP;
use Getopt::Std;
use YAML::Syck;

######
## Config Options
my $timeout = 30;
my $interfaceID;
my $oidIfDescr = ".1.3.6.1.2.1.2.2.1.2.";
my $oidPortStatus = ".1.3.6.1.2.1.2.2.1.7.";
my $oidSysDescr = ".1.3.6.1.2.1.1.1.0.";
my $community;
my $hostname;
my $snmpVersion;
my $targetInterface;
my %options;

if (@ARGV < 1) {
     print "Too few arguments\n";
     usage();
}

getopts("h:H:C:i:V:", \%options);

if ($options{h}){
    usage();
    exit(0);
}
if ($options{H}){
    $hostname = $options{H};
}
else {
    print "No hostname specified\n";
    usage();
    exit(0);
}
my $cacheFile = '/tmp/'.$hostname.'.yaml';
if ($options{C}){
    $community = $options{C};
}
if ($options{i}){
    $targetInterface = $options{i};
}
else {
	print "No interface set";
	exit(1);
}
if ($options{V}){
    $snmpVersion = $options{V};
}
my ($snmpSession, $snmpError) = Net::SNMP->session(
   -community    =>  $community,
   -hostname     =>  $hostname,
   -version      =>  $snmpVersion,
   -timeout      =>  $timeout,
);
if (!defined($snmpSession->get_request($oidSysDescr))) {
	print "Agent not responding, tried SNMP v1 and v2\n";
    exit(3);
}


if (findInterface($targetInterface) == 0){
	reportInterface();
}
else {
	print "Interface $targetInterface not found on device $hostname\n";
	exit(2);
}

$snmpSession->close();

sub findInterface {
	if(-e $cacheFile ) {
		my $yamlData = LoadFile($cacheFile);
		if($yamlData->{$targetInterface}) {
			$interfaceID = $yamlData->{$targetInterface};
			return 0;
		}
	} 
	else {
		system("touch $cacheFile & echo switch: $hostname > $cacheFile");
	}
    unless($interfaceID) {
		my $yamlData = LoadFile($cacheFile);
    	$snmpSession->get_table(-baseoid => $oidIfDescr);
    	my @names = $snmpSession->var_bind_names();
		foreach my $oid (@names) {
			my $results = $snmpSession->get_request($oid);
			my %pdesc = %{$results};
			my @value = split('\.', $oid);
			$yamlData->{$pdesc{$oid}} = $value[11];
            DumpFile($cacheFile, $yamlData);
		}
		if($yamlData->{$targetInterface}) {
            $interfaceID = $yamlData->{$targetInterface};
            return 0;
        }
		return 1;
	}
}

sub reportInterface {
	my $newOID = $oidPortStatus.$interfaceID;
    my $portStatus = $snmpSession->get_request($newOID);
	my %pdesc = %{$portStatus};
	foreach my $status (keys(%pdesc)) {
		if ( $pdesc{$status} == 1 ) {
			print "interface $targetInterface is UP\n";
			exit(0);
		}
		else {
			print "interface $targetInterface is DOWN\n";
			exit(2);
		}
	}
}

sub usage {
    print << "USAGE";
--------------------------------------------------------------------

Monitors status on a switch/mds/router. 

Usage: $0 -H <hostname> -C <community> [...]

Options: -H     Hostname or IP address of switch
         -C     Community (default is public)
         -i     Target interface name 
                Eg: Serial0/0, FastEthernet0/12, fc1/2
         -V     SNMP version
                Eg: 1, 2c (3 not supported)
         -h     Script usage

--------------------------------------------------------------------     
Copyright 2011 Julian De Marchi
         
This program is free software; you can redistribute it or modify
it under the terms of the GNU General Public License
--------------------------------------------------------------------            
                
USAGE
     exit(3);
}
