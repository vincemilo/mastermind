class Board
  attr_reader :code, :n, :l

  def initialize
    @code = []
    @n = 0
    @l = 0
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
      puts 'Improper number of digits, please try again.'
    end
  end

  def check(num)
    if num == @code
      puts 'You win!'
    else
      @n = compare(num)
      @l = location(num)
    end
    p "N:#{@n}"
    p "L:#{@l}"
  end

  def location(array)
    l = 0
    array.zip(@code).map { |a, b| a == b ? l += 1 : 'Not a match' }
    l
  end

  def compare(array)
    arr_nums = array.tally
    arr2_nums = @code.tally

    comp = arr_nums.each.map { |e| e }.sort
    comp2 = arr2_nums.each.map { |e| e }.sort

    i = 0
    n = 0
    smaller_arr = []

    if comp.length > comp2.length
      smaller_arr = comp2
    else
      smaller_arr = comp
    end

    p smaller_arr

    while i < smaller_arr.length

      a1 = comp[i][0]
      a2 = comp2[i][0]
      if a1 == a2
        b1 = comp[i][1]
        b2 = comp2[i][1]
        if b1 == b2
          n += 1
        elsif b1 > b2
          n += b2
        else
          n += b1
        end
      else
        n
      end
      i += 1
    end
    n
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
      'Error. Please try again.'
    end
  end
end

game = Board.new
game.generate_code
game.guess
