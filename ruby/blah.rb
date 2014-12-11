@a = []
f = File.open('bacula.txt') do |f|
  f.lines.each do |line|
   #@a << line.split.map()
    @a << line
 end
end
@b = []
f = File.open('unxwebp08.txt') do |f|
  f.lines.each do |line|
   #@b << line.split.map()
    @b << line
 end
end
@intersection = @a & @b

puts @intersection.size

#puts @a.inspect
#puts @b.inspect


#lines = Array.new

#lines= f.each_line {|line|}

#lines.each do |line|
#  puts line
#end
