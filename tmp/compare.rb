a= []
b= []

a = IO.readlines("bluray.txt")
b = IO.readlines("backups.txt")

compare = a - b 
puts "The following VMs weren't backed up:" 
compare.each do |diff|
  puts "#{diff}"
end
