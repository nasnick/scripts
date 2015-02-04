#!/usr/bin/env ruby

a = ARGV[0]
b = a.gsub(/(.{64})(?=.)/, '\1;\2')
c = b.gsub(/;/, "\n")
puts "-----BEGIN CERTIFICATE-----"
puts c
puts "-----END CERTIFICATE-----"
