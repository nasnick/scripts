a = []
f = File.open('blah') do |f|
  f.lines.each do |line|
    a << line.split.map()
end
end

puts a.inspect

#lines = Array.new

#lines= f.each_line {|line|}

#lines.each do |line|
#  puts line
#end
