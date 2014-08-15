#Author  : ken mcfadden August 2014
#Context : Tealeaf Academy course 1 lesson 2
#Abstract: Blackjack OOP version. 1.0



class Deck

  SUITS = %w{Hearts Diamonds Spades Clubs}
  FACES = %w{2 3 4 5 6 7 8 9 10 J Q K A}

 attr_accessor :cards

  def initialize

    @cards = Array.new

    SUITS.each do |suit|
      FACES.each do |face|
        @cards << Card.new(suit,face)
      end
    end
  end

  def shuffle_the_deck!
    @cards.shuffle!
  end

  def deal_a_card
    @cards.pop
  end

  def to_s
    "#{cards}"
  end

end

module Hand

  attr_accessor :total

  BLACKJACK = 21
  BUST = 22

  def new_card(new_card)
    @card_hand << new_card
  end

  def show_hand
    puts "The #{@player_name} has the following hand:"
    @card_hand.each do |card|
      puts "#{card}"
    end
    puts "Total Hand is : #{get_hand_total}"
    puts ""
  end

  def get_hand_total

    face_values = @card_hand.map{|card| card.face}
     @total = 0
    face_values.each do |val|
      if val == "A"
        @total += 11
      else
        @total += (val.to_i == 0 ? 10 : val.to_i)
      end
    end
    #correct for Aces
    face_values.select{|val| val == "A"}.count.times do
      break if @total <= 21
      @total -= 10
    end
     @total
  end

end

class Card

  attr_accessor :face, :suit

  def initialize(suit,face)
    @face = face
    @suit = suit
  end

  def to_s
    "#{@face} of #{@suit}"
  end

end

class Dealer
  include Hand

  HIT = "h"
  STAND = "s"

  attr_accessor  :card_hand,:player_name,:total,:house_next_step

  def initialize
    @player_name = "House"
    @card_hand = Array.new
    @total = 0
    @house_next_step = nil
  end

  def house_AI
    @house_next_step = HIT
    if @total <=17
      @house_next_step = HIT
    elsif @total <= 20
      @house_next_step = STAND
    end
    @house_next_step
  end

end  #class

class Player
  include Hand

  attr_accessor :card_hand, :player_name , :total

  def initialize(player_name)
    @player_name = player_name
    @card_hand = Array.new
    @total = 0
  end

end  #class

class Game_Engine

  attr_accessor :deck,:game_over,:player,:house,:player_stands,:house_stands,:next_step

  HIT = "h"
  STAND = "s"
  QUIT = "q"
  BUST  = 22
  BLACKJACK = 21

  def initialize
    init_vars
    @deck = Deck.new
    @deck.shuffle_the_deck!
    @player = Player.new("Player")
    @house = Dealer.new
    show_rules
    @player.new_card(@deck.deal_a_card)
    @player.new_card(@deck.deal_a_card)
    @player.show_hand
    @house.new_card(@deck.deal_a_card)
    @house.new_card(@deck.deal_a_card)
    @house.show_hand
    compare_hands
    @house.house_AI
  end

  def init_vars
    @game_over = false
    @house_stands = false
    @player_stands = false
  end

  def show_rules
     puts "Let's play Blackjack!"
     puts "The game will be between 'Player' and the 'Dealer' or 'House'.  You are known as Player."
     puts "To start the game, each player will be dealt two cards."
     puts "After that each player may stand(no more cards), or hit(take another card),"
     puts "The player with the total hand closest to 21 after all cards have been dealt wins. A tie is possible."
     puts "Any player reaching 21 exactly achieves BLACKJACK and automatically wins, unless there is a tie."
     puts "Any player whose total exceeds 21 is said to BUST and loses, unless both players bust, in which case its a tie."
     puts "The house must Hit with any total < 17.  House will stand at 19 or greater."
     puts ""
     puts "Both Player and House have received two cards to begin the game... here is where we stand at this point:"
     puts "--------------------------------------------------------------------------------------------------------"
     puts ""
  end

  def play_game


  while @game_over == false

    player_turn
    house_turn
    compare_hands
    @next_step = @house.house_AI
    if @next_step == STAND
      @house_stands = true
    end

  end  #while loop

  end

  def player_turn

    if @player_stands != true
     begin
      puts "Player turn. You have the option to Hit(take a card) or Stand(you want no more cards). Enter H, S or Q."

      player_decision = gets.chomp.downcase

        if player_decision == QUIT
          puts "Goodbye..thanks for playing."
       @game_over = true
        elsif player_decision == HIT
          @player.new_card(@deck.deal_a_card)
          @player.show_hand
        elsif player_decision == STAND
         @player_stands = true
         puts "Player stands pat."
          puts ""
         end
          player_decision
     end until player_decision != "" || player_decision == STAND || @game_over
    end

  end

  def house_turn
      @house.house_AI
        if @house.house_next_step == HIT
           @house.new_card(@deck.deal_a_card)
           @house.new_card(@deck.deal_a_card)
           @house.show_hand
          @house.house_AI
        elsif @house.house_next_step == STAND
          puts ""
          puts "House has decided to stand on #{@house.total}."
        end
  end

  def compare_hands
      if  @house.total == 21 && @player.total == 21
        puts "We have a PUSH, no one wins!"
       @game_over = true
      elsif
      @house.total >= 22 and @player.total >= 22
        puts "We have a PUSH, no one wins!  Both Busted."
        @game_over = true
      elsif
      @player.total == 21
        puts "Player wins! Blackjack!"
        @game_over = true
      elsif
      @house.total == 21
        puts "The house wins! Blackjack!"
        @game_over = true
      elsif
      @player.total >= 22
        puts "You busted! House wins."
        @game_over = true
      elsif
      @house.total >= BUST
        puts "House went bust! You win."
        @game_over = true
      elsif
      @player_stands == true && @house.total > @player.total
        puts "The house has won with #{@house.total}!"
        @game_over = true
      elsif
        @player_stands == true && @house_stands == true
        puts "Both parties Stand..Game over!"
        @game_over = true
      end
  end

end #engine

# Startup =================
blackjack = Game_Engine.new.play_game