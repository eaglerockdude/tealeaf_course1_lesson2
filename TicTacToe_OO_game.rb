# ken mcfadden / Tealeaf course 1 / Lesson 2  Aug. 2014
# Assignment : Tic Tac Toe OOP version.
# -----
# Grid
# Players
# Mark Choice
# Results

class GameTicTacToe

  attr_accessor :grid


  def initialize
    @grid = Grid.new
    @grid.draw_grid
    @human = Player.new("meat_eater")
    @computer = Player.new("data_eater")
    @winner = nil
    @grid_full = false
    @draw = false
  end

  def play

    begin  #play loop

      # USER TURN
      begin
        puts "Your turn...Choose a position (from 1 to 9) to place a mark:"
        pos = gets.chomp.to_i

          @open_square  = @grid.is_square_open?(pos)  #square open?
          if @open_square == " "
          else
            puts "The square at position #{pos.to_s} is taken...try another."
          end

        end until @open_square == " "
       # User player update
        @update_hash = {pos => "X"}
        @grid.update_mark(@update_hash)
        @grid.draw_grid

      # COMPUTER TURN
        @computer_pick = @grid.computer_pick
        @update_hash = {@computer_pick => "O"}
        @grid.update_mark(@update_hash)
        @grid.draw_grid

      # check for winner
        @winner = @grid.check_for_winner
          if @winner != nil
           puts "#{@winner} has won! Game over."
          end

          if @grid_full
            puts "Game ended in a draw.  No winner."
          end


    end until @winner != nil || @grid_full

  end  # play class end


end

class Player

  def initialize(name)
    @name = name
  end

end

class Grid

  attr_accessor :grid

  def initialize
    @grid = {}    # initialize grid with 9 blank square objects(dumb)
    9.times { |square| @grid[square +1 ] = " " }
    @grid
  end

  def update_mark(update_hash)
    @grid.update(update_hash)
  end

  def is_square_open?(pos)
    @open_square = @grid.fetch(pos)
  end

  def computer_pick
    empty_squares = @grid.keys.select {|position| @grid[position] == " "}
    @empty_square_position = empty_squares.sample
  end

  def check_for_winner
    winning_lines = [[1,2,3], [4,5,6], [7,8,9], [1,4,7], [2,5,8], [3,6,9], [1,5,9], [3,5,7]]
    winning_lines.each do |line|
    return "Player" if @grid.values_at(*line).count('X') == 3
    return "Computer" if @grid.values_at(*line).count('O') == 3
    end
    nil  # if no winner yet
  end

  def grid_full
    find_open_square == []
  end

  def find_open_square
    @grid.keys.select {|position| @grid[position] == " "}
  end


  def draw_grid
    puts "Current game status:"
    puts ""
    puts "     |     |"
    puts "  #{@grid.fetch(1)}  |  #{@grid.fetch(2)}  |  #{@grid.fetch(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@grid.fetch(4)}  |  #{@grid.fetch(5)}  |  #{@grid.fetch(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@grid.fetch(7)}  |  #{@grid.fetch(8)}  |  #{@grid.fetch(9)}"
    puts "     |     |"
    puts
  end

end

class Square

  attr_accessor :square

  def initialize(set_to_blanks)
    @square = set_to_blanks
  end

  def to_s
    "#{@square}"
  end


end

# Mainline

puts "Let's play Tic-Tac-Toe"
puts "You can go first and your mark will b 'X'"
puts "I..(the computer) will go next and my mark will be 'O' "

mygame = GameTicTacToe.new

mygame.play
