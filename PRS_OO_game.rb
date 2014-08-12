# ken mcfadden / Tealeaf course 1 / Lesson 2  Aug. 2014
# Assignment : Rock Paper Scissors OOP version.


class GameRPS

  CHOICES = {'p' =>'Paper', 'r'=>'Rock', 's' =>'Scissors'}
  WINCOMBOS =  {'rs' => 'Rock smashes Scissors', 'sp' => 'Scissors cut Paper', 'pr' => 'Paper covers Rock'}

  attr_reader :the_computer , :player1_choice, :player2_choice
  attr_accessor :player


  def initialize
   @player   = Player.new("self")
   @the_computer = Player.new("auto")
   @player1_choice = ""
   @player2_choice = ""
  end


  def play
    @player1_choice = player.pick
    @player2_choice = the_computer.pick
    who_won
  end

  def who_won

    if player1_choice == player2_choice
      puts "It's a tie game.  You chose #{player1_choice} and the computer chose #{player2_choice}. You have dodged a bullet."

    else

      # Determine da winner:
      uservscomputer = player1_choice + player2_choice
      computervsuser = player2_choice + player1_choice

      if WINCOMBOS::has_key?(uservscomputer)
        puts "You have won because #{WINCOMBOS::fetch(uservscomputer)}!"
      else
        puts "You have been humiliated because #{WINCOMBOS::fetch(computervsuser)}!"
      end

    end
  end


end

class Player

  attr_reader :choice , :choice_type

  def initialize(choice_type)
    @choice = ""
    @choice_type = choice_type
  end

  def pick
    if choice_type == "auto"
      choice = GameRPS::CHOICES.keys.sample
    else
      begin
        puts "You may pick Rock(r), Paper(p), or Scissors(s)"
        user_choice = gets.chomp.downcase
      end  until GameRPS::CHOICES.keys.include?(user_choice)
      choice = user_choice
    end
  end
end


# Mainline

puts "Let's play Rock, Paper, Scissors"
puts "Here are the rules :  Rock smashes scissors, scissors cuts paper, and paper covers rock."
puts "You will go first with your choice, and the the computer will randomly makes it's choice."
puts "Choices are R for rock, P for paper, and S for scissors."

game  = GameRPS.new

game.play

puts "bye"

