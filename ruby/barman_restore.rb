#!/usr/bin/env ruby

require 'fileutils'
require 'etc'

@exit_status = 0
@folder = '/data/db/barmanrestored/'
@seven_five_five = 0755
@seven_zero_zero = 0700

def restore
  before_restore
  if @exit_status == 0
     restore_command
  else
     puts "couldn't stop postgres... exiting"
  end
  if @exit_status == 0
     puts "restore successful.. starting postgres"
     after_restore
  else
    "Restore not successful... exiting"
    exit 1
  end
end

def restore_command
  system "sudo -u barman barman recover main latest /data/db/barmanrestored/"
  @exit_status = $?.exitstatus
end

def before_restore
  stop_postgres
  change_ownership("barman")
  change_permissions(@seven_five_five)
  edit_backup_info
end

def after_restore
  change_ownership("postgres")
  change_permissions(@seven_zero_zero)
  create_symlink
  start_postgres
end

def change_ownership(user)
  FileUtils.chown_R user, user, @folder
end

def change_permissions(permissions)
  FileUtils.chmod permissions, @folder
end

def edit_backup_info
  backup = `barman list-backup main`
  latest_backup = backup[5,15]
  backup_info = "/data/pgbarman/barman/main/base/#{latest_backup}/backup.info"
  text = File.read(backup_info)
  new_contents = text.gsub(/oltp/, "db\/barmanrestored")
    File.open(backup_info, "w") {|file| file.puts new_contents }
end

def create_symlink
  system "sudo -u postgres ln -s @folder oltp"
end

def stop_postgres
  system "sudo -u postgres /etc/init.d/postgresql stop"
  @exit_status = $?.exitstatus
  @exit_status = 0
  
end

def start_postgres
  system "sudo -u postgres /etc/init.d/postgresql start"
  @exit_status = $?.exitstatus
end

restore
