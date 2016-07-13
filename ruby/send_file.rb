#!/usr/bin/env ruby
require 'fileutils'
require 'mail'

date=@option.file_date@
log_file="sidekiq.log-#{date}.bz2"

if File.exist?("/srv/www/orahq.com/current/log/#{log_file}")
  Dir.chdir("/srv/www/orahq.com/current/log/")
  FileUtils.cp "#{log_file}", "/tmp/#{log_file}_copy.bz2"
  system "bunzip2 #{log_file}_copy.bz2"
else
  puts "File doesn't exist"
end


Mail.deliver do
  from      "rundeck@localhost.com"
  to        @option.email_address@
  subject   "Sidekiq log for" @option.file_date@
  body      "Hello world"
  add_file  "/srv/www/orahq.com/current/log/#{log_file}_copy"
end

Dir.chdir("/srv/www/orahq.com/current/log/") do
  FileUtils.rm "#{log_file}_copy"
  FileUtils.rm "#{log_file}_copy.bz2"
end
