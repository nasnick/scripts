#!/usr/bin/env ruby

require 'fileutils'
require 'etc'

$exit_status = 0
$folder = '/data/db/barmanrestored/'
$seven_five_five = 0755
$seven_zero_zero = 0700

def restore
  puts "[+] Preparing for backup..."
  before_restore
  if $exit_status == 0
     restore_command
  else
     puts "[+] Couldn't stop postgres... exiting"
     exit
  end
  if $exit_status == 0
     puts "[+] Restore successful.."
     after_restore
     if $exit_status != 0
       puts "[+] Unable to start postgres..."
     end
  else
    "[+] Restore not successful... exiting"
    exit
  end
end

# Kick off the barman restore
def restore_command
  puts "[+] Beginning restore..."
  system "sudo -u barman barman recover main latest /data/db/barmanrestored/"
  $exit_status = $?.exitstatus
end

# Set ownership and permissions prior to kicking off barman restore
def before_restore
  stop_postgres
  # Remove symlink to oltp
  FileUtils.rm_r '/data/db/oltp'
  create_directory
  change_ownership("barman")
  change_permissions($seven_five_five)
  edit_backup_info
end

# Restore ownership and permissions to folder and create symlink to oltp
def after_restore
  change_ownership("postgres")
  change_permissions($seven_zero_zero)
  create_symlink
  start_postgres
end

def change_ownership(user)
  puts "[+] Changing ownership of #{$folder} to #{user}"
  FileUtils.chown_R user, user, $folder
end

def change_permissions(permissions)
  puts "[+] Changing permissions of #{$folder} to #{permissions}"
  FileUtils.chmod permissions, $folder
end

# Edit backup.info file so table spaces can be correctly set during restore
def edit_backup_info
  backup = `barman list-backup main`
  latest_backup = backup[5,15]
  backup_info = "/data/pgbarman/barman/main/base/#{latest_backup}/backup.info"
  text = File.read(backup_info)
  new_contents = text.gsub(/oltp/, "db\/barmanrestored")
    File.open(backup_info, "w") {|file| file.puts new_contents }
end

def create_symlink
  Dir.chdir("/data/db") do
  puts "[+] Creating symlink 'oltp -> #{$folder}'"
  system "sudo -u postgres ln -s #{$folder} oltp"
  end
end

def create_directory
  if Dir.exists?($folder)
    puts "[+] Removing directory #{$folder}"
    FileUtils.rm_rf($folder)
    puts "[+] Creating directory #{$folder}"
    FileUtils.mkdir_p $folder
  else
    puts "[+] Creating directory #{$folder}"
    FileUtils.mkdir_p $folder
  end
end

def stop_postgres
  puts "[+] Stopping postgres..."
  system "sudo -u postgres /etc/init.d/postgresql stop"
  $exit_status = $?.exitstatus
end

def start_postgres
  puts "[+] Starting postgres..."
  system "sudo -u postgres /etc/init.d/postgresql start"
  $exit_status = $?.exitstatus
end

restore
