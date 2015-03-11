#Practice writing classes based on what has been learned in Pragmatic Studio course.
#
class HelloThere
  attr_reader :name, :age
  def initialize(name, age)
  @name = name
  @age = age
end

def upper
  puts @name.upcase
end

def print_greeting
  puts "Hello #{@name} how are you today? I heard you turned #{@age} the other day."
  end
end


class MessWithPerson
  def initialize(title)
    @title = title
    @people = []
  end

  def add_person(a_person)
    @people << a_person
  end

  def print_people
    @people.each do |person|
      puts "Hello #{person.name} you #{person.age} year old codger."
    end
  end
end

person = HelloThere.new('roger', 24)
person.print_greeting
person.upper

bozo = MessWithPerson.new('bozo')
bozo.add_person(person)
bozo.print_people


