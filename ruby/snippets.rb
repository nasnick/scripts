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
