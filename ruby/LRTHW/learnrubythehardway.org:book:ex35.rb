def gold_room
  puts "this room is full of gold"
  puts "how much gold would you like?"
  
  print "> "
  choice = $stdin.gets.chomp
  
  if choice.include?("0g") || choice.include?("1")
    how_much = choice.to_i
  else
    dead("Man, learn to type a number")
  end
    if how_much < 50
      puts "Nice, you're not greedy. You win!"
      exit(0)
    else
      dead("you greedy so n so")
    end
  end
  
  def bear_room
    puts "There is a bear here."
    puts "The bear has a bunch of honey."
    puts "The fat bear is in front of another door."
    puts "How are you going to move the bear?"
    bear_moved = false
    
    while true
      print "> "
      choice = $stdin.gets.chomp
      
      if choice == "take_honey"
        dead("the bear slaps ur muku off")
      elsif choice == "taunt bear" && !bear_moved
        puts "The bear has moved from the door. You can go through it now."
        bear_moved = true
      elsif choice == "taunt bear" && bear_moved
        dead("leg be goneski")
      elsif choice == "open door" && bear_moved
        gold_room
      else
        puts "no idea"
      end
    end
  end
  
  def cthulhu_room
    puts "Here you see the great evil Cthulhu."
    puts "He, it, whatever stares at you and you go insane."
    puts "Do you flee for your life or eat your head?"
    
    print "> "
    choice = $stdin.gets.chomp
    
    if choice.include? "flee"
      start
    elsif choice.include? "head"
      dead("well that was tasty")
    else
      cthulhu_room
    end
  end
  
  def dead(why)
    puts why, "Good job!"
    exit(0)
  end
  
  def start
    puts "You are in a dark room."
    puts "There is a door to your right and left."
    puts "Which one do you take?"

    print "> "
    choice = $stdin.gets.chomp
    
    if choice == "left"
      bear_room
    elsif choice == "right"
      cthulhu_room
    else
      dead("You stumble around the room until you starve.")
    end
  end

start