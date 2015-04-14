def fizzbuzz(number)
  num = 0
  while num < 101
    if number % 15 == 0
      puts 'fizzbuzz'
    elsif number % 3 == 0 
      puts 'fizz'
    elsif number % 5 == 0
      puts 'buzz'
    else
      puts number  
    end
   num += 1
   number += 1
 end
end
fizzbuzz(0)