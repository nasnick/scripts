#!/usr/bin/env ruby
#formats public cert in the correct way.
#Run from command line with public cert as argument 
#e.g. ./process_cert.rb adlkadlkjadjkad...etc

a = ARGV[0]
b = a.gsub(/(.{64})(?=.)/, '\1;\2')
c = b.gsub(/;/, "\n")

puts "-----BEGIN CERTIFICATE-----"
puts c
puts "-----END CERTIFICATE-----"
