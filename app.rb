class Board
  attr_reader :code, :n, :l, :guesses

  def initialize
    @code = []
    @n = 0
    @l = 0
    @guesses = 11
  end

  def generate_code
    i = 5
    while i.positive?
      num = rand(1..5)
      @code.push(num)
      i -= 1
    end
    guess
  end

  def guess
    while @guesses <= 12
      puts 'Enter your guess (5 digits):'
      num = gets.chomp
      unless num.length == 5
        puts 'Improper number of digits, please try again.'
      else
        num = num.split('')
        num.map!(&:to_i)
        check(num)
        @guesses += 1
        if @guesses > 12
          puts "Sorry you lose. The code was #{@code}."
          return
        end
      end
    end
  end

  def check(num)
    puts "You entered: #{num}"
    if num == @code
      puts "You win! It took you #{@guesses} tries."
      @guesses = 13
      return
    else
      @n = compare(num)
      @l = location(num)
    end
    puts "Numbers Correct: #{@n}"
    puts "Locations Correct: #{@l}"
    puts "You have #{12 - @guesses} guesses remaining."
  end

  def location(array)
    l = 0
    array.zip(@code).map { |a, b| a == b ? l += 1 : 'Not a match' }
    l
  end

  def compare(array)
    i = 1
    n = 0
    while i <= 5
      a = array.count(i)
      b = @code.count(i)
      unless a.zero? && b.zero?
        if a == b
          n += a
        elsif a > b
          n += b
        else
          n += a
        end
      end
      i += 1
    end
    n
  end

  def play_game
    puts "Welcome to Mastermind!/n"
    puts ''
    puts 'You have 12 tries to break a 5 digit code.'
    puts ''
    puts 'If the numbers you selected are correct, the amount of correct
numbers will be displayed to the right of the Number Correct: column.'
    puts ''
    puts 'If you have selected the correct location for those numbers, it will
be displayed to the right of the Locations Correct: column.'
    puts ''
    puts 'For example, let\'s say the secret code is 1, 1, 3, 2, 5'
    puts ''
    puts 'If you were to put in 1, 5, 3, 4, 3 as your guess, you would get a
display of N: 3, because 3 numbers you guessed were correct (1, 5, 3) and L: 2
because 2 were in the correct location as well (the 1 and the 3).'
    puts ''
    puts 'The game is won if you guess the correct location for all 5 numbers
(L: 5) before the end of 12 turns. Good luck!'
    puts ''
    puts 'Are you ready to play? (Enter y to continue or any other key to quit)'
    go = gets.chomp
    if go == 'y'
      p 'Ok let\'s go!'
      generate_code
    else
      'Error. Please try again.'
    end
  end
end

game = Board.new
game.play_game
