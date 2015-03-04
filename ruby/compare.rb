a= []
b= []

a = IO.readlines("backups.txt")
b = IO.readlines("backups-list.txt")

compare = b - a
puts "The following VMs weren't backed up:" 
puts "#{compare.to_s}"
