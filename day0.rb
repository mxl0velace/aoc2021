class Greeter
    attr_accessor :name

    def initialize(name = "World")
        @name = name
    end
    def say_hi
        puts "Hi #{@name}!"
    end
    def say_bye
        puts "Bye #{@name}..."
    end
end

if __FILE__ == $0
    greet = Greeter.new
    greet.say_hi
    greet.say_bye

    greetBob = Greeter.new("Bob")
    greetBob.say_hi
    greetBob.say_bye
    greetBob.name = "Robert"
    greetBob.say_hi
end