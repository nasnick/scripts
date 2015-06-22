

out = File.new("/Users/nickschofield/Desktop/out.txt", "w")

File.foreach("/Users/nickschofield/Desktop/FemaleNamesUnique.txt") { |line|
  out.puts line unless line.chomp.empty?
}

file = File.open("/Users/nickschofield/Desktop/FemaleNamesUnique.txt", "rb")
# contents = file.read
a = IO.readlines(file)

# a = contents.split(' ')

# dict = {}
# a.each do |word|
# 	dict[:Icelandic] = word
# end

 # I18n.transliterate(a)

# puts dict

# c = []		
# a.each do |word|
# 	if word[0] == 'a'
# 		c << word
# 	end
# end

# puts c

puts "how many words do you want? "
word_amount = gets.to_i
puts "word between what length? (start)"
word_start = gets.to_i
puts "word between what length? (end)"
word_end = gets.to_i

word_amount.times do
	word = a.sample.capitalize
	if word.length > word_start && word.length < word_end
	 	puts word
 	puts "\n"
	end
end