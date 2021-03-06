class Board
  attr_reader :code, :n, :l, :guesses, :set, :human

  def initialize
    @code = []
    @n = 0
    @l = 0
    @guesses = 1
    @set = (1111..6666).to_a
    @human = true
  end

  protected

  def generate_code
    i = 4
    while i.positive?
      num = rand(1..6)
      @code.push(num)
      i -= 1
    end
    guess
  end

  def computer_guess(guess)
    no_match if @guesses == 1
    check(guess)
    if @n.zero?
      i = 1
      while i < 4
        no_match(guess[i].to_s)
        i += 1
      end
    else
      match(guess)
    end
    @guesses += 1
    return if guesses >= 12

    new_guess(guess)
  end

  def new_guess(guess)
    i = @set.length - 1
    while i >= 0
      matches = 0
      conv = @set[i].to_s.split('').map(&:to_i)
      guess.zip(conv) { |a, b| a == b ? matches += 1 : 'Not a match' }
      @set.delete_at(i) if matches > @l
      i -= 1
    end
    new_guess = @set[0].to_s.split('').map(&:to_i)
    @set.delete_at(0)
    computer_guess(new_guess)
  end

  def match(guess)
    i = @set.length - 1
    j = 0
    perms = guess.permutation(@n).to_a
    unique_perms = perms.uniq.tally
    while j < unique_perms.length
      while i >= 0
        conv = @set[i].to_s.split('').map(&:to_i)
        unique_set = conv.permutation(@n).to_a.tally
        @set.delete_at(i) unless unique_perms.any? { |k, _| unique_set.key? k }
        i -= 1
      end
      j += 1
    end
  end

  def no_match(num = '0')
    i = @set.length - 1
    while i >= 0
      conv = @set[i].to_s.split('')
      @set.delete_at(i) if conv.any?(num)
      i -= 1
    end
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
    if @human == true
      puts "You entered: #{num}"
    else
      puts "Computer enters: #{num}"
    end
    if @guesses >= 12
      puts "Sorry you lose. The code was #{@code}."
      return
    elsif num == @code
      if @human == true
        puts "You win! It took you #{@guesses} tries."
      else
        puts "The Computer wins! It took them #{@guesses} tries."
      end
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
    while i <= 6
      a = array.count(i)
      b = @code.count(i)
      unless a.zero? && b.zero?
        n += if a > b
               b
             else
               a
             end
      end
      i += 1
    end
    n
  end

  public

  def play_game
    puts 'Welcome to Mastermind!'
    puts ''
    puts 'You have 12 tries to break a 4 digit code.'
    puts ''
    puts 'Choose numbers between 1 - 6. If the numbers you selected are correct,the amount of correct
numbers will be displayed to the right of the Number Correct: column.'
    puts ''
    puts 'If you have selected the correct location for those numbers, it will
be displayed to the right of the Locations Correct: column.'
    puts ''
    puts 'For example, let\'s say the secret code is 1, 3, 3, 6'
    puts ''
    puts 'If you were to put in 1, 6, 3, 2 as your guess, you would get a
display of Numbers Correct: 3, because 3 numbers you guessed were correct
(1, 6, 3) and Locations Correct: 2 because 2 were in the correct location as
well (the 1 and the 3).'
    puts ''
    puts 'The game is won if you guess the correct location for all 4 numbers
(Locations Correct: 4) before the end of 12 turns.'
    puts ''
    puts 'You also have the option of creating a code and having the computer
try to break it.'
    puts ''
    puts 'Press 1 if you would like to be the code BREAKER. Press 2 if you
would like to be the code MAKER.'
    go = gets.chomp
    if go == '1'
      puts 'Good luck!'
      generate_code
    elsif go == '2'
      @human = false
      puts ''
      puts 'Please enter your 4 digit code you would like the computer to
break.'
      keep_going = true
      while keep_going == true
        num = gets.chomp.split('').map(&:to_i)
        if num.length != 4 || num.any? { |e| e < 1 || e > 6 }
          puts 'Code must be 4 digits long using numbers 1-6, please try again.'
        else
          keep_going = false
          @code = num
          computer_guess([1, 1, 2, 2])
        end
      end
    end
  end
end

game = Board.new
game.play_game
