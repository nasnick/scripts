@a = []
f = File.open('bacula.txt') do |f|
  f.lines.each do |line|
   #@a << line.split.map()
    @a << line

 end
  puts "file 1: #{@a.size}"
end
@b = []
f = File.open('unxwebp08.txt') do |f|
  f.lines.each do |line|
   #@b << line.split.map()
    @b << line
    
    @c = @a - @b
    @intersection = @a & @b
 end
  puts "file 2: #{@b.size}"
end
puts "Intersection size: #{@intersection.size}"

puts "These files are not common to both:"
puts @c

#puts @a.inspect
#puts @b.inspect


#lines = Array.new

#lines= f.each_line {|line|}

#lines.each do |line|
#  puts line
#end
#bacula.txt
#unxwebp08.txt
