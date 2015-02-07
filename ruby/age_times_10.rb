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
#   end
# end
# number

# '4' == 4 ? puts("TRUE") : puts("FALSE")

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
#
# def numbers(x,y)
#   case
#   when (y + 1) == x
#     puts "ALRIGHT NOW!"
#   end
#  end
# numbers(9,10) 

    
  # when (x + 1) >= (y)
#     puts "Alright now!"
#
#
#   when (y + 1) == x
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


