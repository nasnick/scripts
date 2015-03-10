def count(number) 
  while number != 101
    if number % 5 == 0 and number % 3 == 0
      puts "SiteHost"
    elsif number % 3 == 0
      puts "Site"
    elsif number % 5 == 0
      puts "Host"
    else
      puts number
    end
    number += 1
  end
end

count(1)

################
++++++++++++++++
################

# def OneHundred(number):
#
#         while number > 0:
#                 if number % 5 == 0 and number % 3 == 0:
#                         print "SiteHost"
#                 elif number % 3 == 0:
#                         print "Site"
#                 elif number % 5 == 0 :
#                         print "Host"
#                 else:
#                     print number
#                 number -= 1
# OneHundred(100)

################
++++++++++++++++
################

open('beans.txt', "w") do |file|
	file.puts("lima beans")
	file.puts("roger beans")
end

################
++++++++++++++++
################

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

################
++++++++++++++++
################

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
puts "Lines in common: #{@intersection.size}"

puts "These lines are not common to both:"
puts @c

(a)
1
2
3
4
a
b
c

(b)
1
2
4
a
b
d

################
++++++++++++++++
################

#
# def how_old
#
#   puts "how old is ya?"
#   print "> "
#
#   choice = $stdin.gets.chomp
#   ten=choice.to_i + 10
#   twenty=choice.to_i + 20
#   thirty=choice.to_i + 30
#
#   puts "In 10 years you will be: #{ten}"
#   puts "In 20 years you will be: #{twenty}"
#   puts "In 30 years you will be: #{thirty}"
# end
# #how_old
#
# def name
#     puts "what's ur name?"
#   print "> "
#
#   name = $stdin.gets.to_s
#   10.times do print name
#   end
# end
# #name
#
# def first_last_name
#   puts "what's ur first name?"
#   print "> "
#   first = gets.chomp
#   puts "what's ur last name?"
#   print "> "
#   last = gets.chomp
#
#   puts first + " " + last
# end
# first_last_name

################
++++++++++++++++
################

# a = 5
#
# answer = case
#   when a == 5
#     "a is 5"
#   when a == 6
#     "a is 6"
#   else
#     "a is neither 5, nor 6"
#   end
#
# puts answer

# a = 5
# if a
#   puts "how can this be true?"
# else
#   puts "it is not true"
# end

# def upper(sentence)
#
#   if sentence.length > 10
#     sentence.upcase
#   else
#     sentence
#   end
# end
# puts upper("hello there today")

################
++++++++++++++++
################


# def number
#   puts "number between 1-100"
#   print "> "
#   num = gets.chomp.to_i
#
#   if (num <= 0) || (num >= 101)
#     puts "between 1-100 pls"
#   elsif (num >= 0 ) && (num <= 50)
#     puts "between 0 and 50"
#   elsif
#     puts "between 51 and 100"
#   end'
# end
# number

################
++++++++++++++++
################

# '4' == 4 ? puts("TRUE") : puts("FALSE")

################
++++++++++++++++
################

# x = 2
#    if ((x * 3) / 2) == (4 + 4 - x - 3)
#      puts "Did you get it right?"
#    else
#      puts "Did you?"
#    end
#
# y = 9
# x = 10
# if (x + 1) <= (y)
#   puts "Alright."
# elsif (x + 1) >= (y)
#   puts "Alright now!"
# elsif (y + 1) == x
#   puts "ALRIGHT NOW!"
# else
#   puts "Alrighty!"
# end

# def numbers(x,y)
#   case
#   when (x + 1) <= (y)
#     puts "Alright."
#   end
#  end
# numbers(9,10)
#
# def numbers(x,y)
#   case
#   when (x + 1) >= (y)
#     puts "Alright now!"
#   end
#  end
# numbers(9,10)
#########################
#
# def numbers(x,y)
#   case
#   when (y + 1) == x
#     puts "ALRIGHT NOW!"
#   end
#  end
# numbers(9,10) 
#
#  when (x + 1) >= (y)
#     puts "Alright now!"
#
#
#  when (y + 1) == x
#     puts "ALRIGHT NOW!"
#
#
#   else
#     puts "Alrighty!"
#   end
# end
# numbers(9,10)  


# a = 5
#
# case a
# when 5
#   puts "a is 5"
# when 6
#   puts "a is 6"
# else
#   puts "a is neither 5, nor 6"
# end

################
++++++++++++++++
################

def foo(x)
 [x, x+ 1]
end
 => nil 
a,b = foo(4)
 => [4, 5]
 
 a =[]

################
++++++++++++++++
################

a = IO.readlines("/home/nschofield/scripts/pen_test.txt")
b = test.grep(a) /Threat: High/
puts b
#puts a[4]

################
++++++++++++++++
################

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

################
++++++++++++++++
################

# this one is like your scripts with ARGV
def print_two(*args)
arg1, arg2 = args
puts "arg1: #{arg1}, arg2: #{arg2}"
end
print_two("Zed","Shaw")

################
++++++++++++++++
################

name = "Fred"
=> "Fred" 
x = name == 'Fred' ? 10 : 5
=> 10 
name = "John"
=> "John" 
x = name == 'Fred' ? 10 : 5
=> 5 

################
++++++++++++++++
################

age = 5
=> 5 
puts "clean your room" unless age < 4
clean your room
=> nil 
puts "clean your room" unless age > 4
=> nil 

################
++++++++++++++++
################
ARRAYS
#Array reduce method

numbers
 => [24, 13, 8, 65] 
numbers.reduce(:+)
 => 110 
numbers.reduce {|c,d| c + d}
 => 110 
 
################
++++++++++++++++
################

Array: spaceship operator

>> numbers.sort { |a, b| b <=> a }
=> [65, 24, 13, 8]

################
++++++++++++++++
################

Partition odd and even

numbers
=> [24, 13, 8, 65] 
evens, odds = numbers.partition {|evens, odds| evens.even?}
=> [[24, 8], [13, 65]] 

10.times do b << rand(1..8) end
 => 10 
2.0.0-p481 :083 > b
 => [5, 5, 4, 1, 6, 1, 7, 8, 8, 2] 
2.0.0-p481 :084 > b.sort
 => [1, 1, 2, 4, 5, 5, 6, 7, 8, 8]
 
x,y = b.partition {|x,y| x.even?}
  => [[4, 6, 8, 8, 2], [5, 5, 1, 1, 7]] 

################
++++++++++++++++
################
Sort

 => ["a", "pink", "salmon", "is", "a", "very", "good", "thing"]
  
a.sort {|a,b| a.length <=> b.length}
=> ["a", "a", "is", "pink", "very", "good", "thing", "salmon"] 
a.sort {|a,b| a <=> b}
=> ["a", "a", "good", "is", "pink", "salmon", "thing", "very"]

reject if the first letter is s:
a.reject {|a| a[0] == 's'}
 => ["a", "pink", "is", "a", "very", "good", "thing"]
 
 
numbers = [32, 34, 44, 66]
  => [32, 34, 44, 66] 
numbers.any? {|n| n > 60}
  => true 
numbers.detect {|n| n > 60}
  => 66 
numbers.detect {|n| n > 40}
  => 44 
numbers.map {|n| n * 20}
  => [640, 680, 880, 1320]
  
################
++++++++++++++++
################
HASHES

snacks = {roger: 20, tan: 23, peter: 44}
 => {:roger=>20, :tan=>23, :peter=>44} 
snacks.each do |name, value|
     puts "this #{name} has a value of #{value}"
end
this roger has a value of 20
this tan has a value of 23
this peter has a value of 44
  
snacks.each {|snack, name| puts "#{snack} has a value of #{name}"}
roger has a value of 20
tan has a value of 23
peter has a value of 44

################
++++++++++++++++
################

moes_treasures
 => {:hammer=>50, :crowbar=>120}
 
REDUCE

moes_treasures.values.reduce(:+)
=> 170 
 
################
++++++++++++++++
################
#Look up values in a hash but iterating through letters in a word. Acculate the values.

letters = {"c" => 3, "e" => 1, "l" => 1, "n" => 1, "t" => 1, "x" => 8, "y" => 4}

total_points = Hash.new(0)
'excellently'.each_char {|k| total_points[k] += letters[k]}

puts total_points
puts total_points.values.reduce(:+)
