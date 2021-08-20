class Board
  attr_reader :code

  def initialize
    @code = []
  end

  def generate_code
    i = 5
    while i > 0
        num = rand(1..5)
        @code.push(num)
        i -= 1
    end
    p @code
  end

  def guess
    puts 'Enter your guess (5 digits):'
    num = gets.chomp
    if num.length == 5
        num = num.split('')
        num.map!(&:to_i)
        check(num)
    else
        puts 'improper length'
    end
  end

  def check(num)
    if num == @code
        puts 'You win!'
    else
        puts 'Try again'
    end
  end

  def play_game
    puts 'Welcome to Mastermind!'
    puts ''
    puts 'You have 12 tries to break a 5 digit code.'
    puts ''
    puts 'If the numbers you selected are correct, the amount of correct
numbers will be displayed to the right of the N: column.'
    puts ''
    puts 'If you have selected the correct location for those numbers, it will
be displayed to the right of the L: column.'
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
      return
    end
  end
end

game = Board.new
game.generate_code
game.guess