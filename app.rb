class Board
  attr_reader :code, :n, :l, :guesses

  def initialize
    @code = []
    @n = 0
    @l = 0
    @guesses = 10
  end

  def generate_code
    i = 4
    while i.positive?
      num = rand(1..4)
      @code.push(num)
      i -= 1
    end
    p @code
    guess
  end

  def guess
    while @guesses < 12
      puts 'Enter your guess (4 digits):'
      num = gets.chomp
      if num.length == 4
        num = num.split('')
        num.map!(&:to_i)
        @guesses += 1
        check(num)
      else
        puts 'Improper number of digits, please try again.'
      end
    end
  end

  def check(num)
    puts "You entered: #{num}"
    if @guesses >= 12
      puts "Sorry you lose. The code was #{@code}."
      return
    elsif num == @code
      puts "You win! It took you #{@guesses} tries."
      @guesses = 13
      return
    else
      @n = compare(num)
      @l = location(num)
    end
    status
  end

  def status
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
    while i <= 4
      a = array.count(i)
      b = @code.count(i)
      unless a.zero? && b.zero?
        n += if a == b
               a
             elsif a > b
               b
             else
               a
             end
      end
      i += 1
    end
    n
  end

  def play_game
    puts 'Welcome to Mastermind!'
    puts ''
    puts 'You have 12 tries to break a 4 digit code.'
    puts ''
    puts 'If the numbers you selected are correct, the amount of correct
numbers will be displayed to the right of the Number Correct: column.'
    puts ''
    puts 'If you have selected the correct location for those numbers, it will
be displayed to the right of the Locations Correct: column.'
    puts ''
    puts 'For example, let\'s say the secret code is 1, 1, 3, 5'
    puts ''
    puts 'If you were to put in 1, 5, 3, 3 as your guess, you would get a
display of Numbers Correct: 3, because 3 numbers you guessed were correct
(1, 5, 3) and Locations Correct: 2 because 2 were in the correct location as
well (the 1 and the 3).'
    puts ''
    puts 'The game is won if you guess the correct location for all 4 numbers
(Locations Correct: 4) before the end of 12 turns. Good luck!'
    puts ''
    puts 'Are you ready to play? (Enter y to continue or any other key to quit)'
    go = gets.chomp
    if go == 'y'
      puts 'Good luck!'
      generate_code
    else
      'Error. Please try again.'
    end
  end
end

game = Board.new
game.play_game
