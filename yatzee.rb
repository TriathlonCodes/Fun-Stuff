require_relative 'game_class'

class Yahtzee
	def initialize
		die1 = Die.new(6)
		die2 = Die.new(6)
		die3 = Die.new(6)
		die4 = Die.new(6)
		die5 = Die.new(6)
		@dice = [die1, die2, die3, die4, die5]
		@successes = {"yatzee" => 0,
			"straight" => 0,
			"full_house" => 0,
			"four_of_a_kind" => 0,
			"three_of_a_kind" => 0
		}
	end
	attr_reader :die_values, :successes, :total_score, :valid_responses
	def take_turn
		first_roll
		second_roll
		third_roll
		evaluate
	end
	def first_roll
		@die_values = []
		n=1
		@dice.each do |die|
			value = die.roll
			puts "Die #{n} rolls a #{value}"
			@die_values << value
			n += 1
		end
		p @die_values
	end
	# @valid_responses = ["none", "1", "2", "3", "4", "5"]
	def second_roll
		puts "Which dice would you like to re-roll? (numbers only separated by a space or 'none' please)"
		dice_to_reroll = gets.chomp.split(" ")
		dice_to_reroll.each do |die_num|
			unless [1,2,3,4,5].to_a.include? die_num.to_i || die_num == "none"
				puts "I'm sorry, that is not a valid response."
				second_roll
			end
		end
		if dice_to_reroll == ["none"]
			return
		else
			dice_to_reroll.map! {|die_num| die_num.to_i}
			dice_to_reroll.each do |die_num|
				@die_values[die_num-1] = @dice[die_num-1].roll
			end
		end
		p @die_values
	end
	def third_roll
		puts "Which dice would you like to re-roll? (numbers only separated by a space or 'none' please)"
		dice_to_reroll = gets.chomp.split(" ")
		if dice_to_reroll == ["none"]
			return
		end
		dice_to_reroll.each do |die_num|
			unless die_num == ["none",1,2,3,4,5].include? (die_num.to_i)
				puts "I'm sorry, that is not a valid response."
				third_roll
			end
		end
		if dice_to_reroll == ["none"]
			return
		else
			dice_to_reroll.each do |die_num|
				@die_values[die_num-1] = @dice[die_num-1].roll
			end
		end
		p @die_values
	end
	def evaluate
		puts ""
		if yatzee? == true
			puts "Yatzee!"
			@successes["yatzee"] += 1
		elsif straight? == true
			puts "Straight!"
			@successes["straight"] += 1
		elsif full_house? == true
			puts "Full house!"
			@successes["full_house"] += 1
		elsif four_of_a_kind? == true
			puts "Four of a kind!"
			@successes["four_of_a_kind"] += 1
		elsif three_of_a_kind? == true
			puts "Three of a kind!"
			@successes["three_of_a_kind"] += 1
		else
			puts "Not a winner"
		end
	end
	def yatzee?

		match = []
		@die_values.each do |value|
			if value == @die_values[4]
				match << true
			else
				match << false
			end
		end
		if match.include? false
			return false
		else
			return true
		end
	end
	def straight?
		@die_values.sort!
		if @die_values == [1,2,3,4,5] || @die_values == [2,3,4,5,6]
			return true
		else
			return false
		end
	end
	def full_house?
		match = []
		@die_values.sort!
		@die_values.each do |value|
			if value == @die_values[2]
				match << value
			end
		end
		if match.length == 3
			two_of_a_kind = @die_values.select{|value| value if value != match[0]}
			if two_of_a_kind[0] == two_of_a_kind[1]
				return true
			else
				return false
			end
		end
	end
	def four_of_a_kind?
		match = []
		@die_values.sort!
		@die_values.each do |value|
			if value == @die_values[2]
				match << value
			end
		end
		if match.length == 4
			return true
		else
			return false
		end
	end
	def three_of_a_kind?
		match = []
		@die_values.sort!
		@die_values.each do |value|
			if value == @die_values[2]
				match << value
			end
		end
		if match.length == 3
			return true
		else
			return false
		end
	end
	def score
		@total_score = 0
		n=50
		puts "You've gotten the following results:"
		@successes.each do |type, score|
			puts "#{score} #{type}"
			@total_score = n * score + @total_score
			n = n - 10
		end
		puts "Your total score is:  #{total_score}"
	end
end

class NewGame
	def initialize(game)
		@game = game.downcase
		valid_games = ["yahtzee"]
		unless valid_games.include? game
			raise ArgumentError.new("I'm sorry, that is not a game we have to offer.")
		end
		puts "Welcome to game center! You have selected to play #{game.upcase}!"
		get_info
		start_new_game
	 end
	def get_info
		@players = {}
		puts "How many players are playing? (Max 6)"
		num_players = gets.chomp.to_i
		unless num_players>0 && num_players<7
			puts "I'm sorry, that is an invalid response."
			get_info
		end
		num_players.times do
			puts "Please provide a player's name."
			player = gets.chomp
			@players[player]=player
		end
	end
	def start_new_game
		case @game
		when "yahtzee"
			puts "Let's play..."
			sleep(1)
			puts "              ___ ___ ___ ___  "
			puts '\ /  /\  |  |  |    / |_  |_   |||'
			puts ' V  /__\ |__|  |   /  |   |    |||'
			puts ' | /    \|  |  |  /__ |__ |__  ooo'
			play_yahtzee
		end
	end
	attr_accessor :players, :games, :game
	def play_yahtzee

		scoring_comparison={}
		@winning_score = 0
		@players = @players.map {|player_name, player_game|
			[player_name, player_game = Yahtzee.new]
		}
		10.times do
			@players.each do |player_name, player_game|
				puts ""
				puts "-------"
				sleep(1)
				puts "It's #{player_name}'s turn. (Press Enter to continue)"
				puts "-------"
				gets
				player_game.take_turn
			end
		end
		@players.each do |player_name, player_game|
			puts "=================="
			puts " "
			puts player_name
			puts "------------------"
			player_game.score
			scoring_comparison[player_name] = player_game.total_score
			if @winning_score < player_game.total_score == true
				@winning_score = player_game.total_score
			end
		end
		winner = scoring_comparison.select{|player, score| score == @winning_score}
		puts "-=-=-=-=-=-=-=-=-=-=-=-"
		if winner.length > 1
			puts "It's a tie between:"
			winner.each do |player, score|
				puts player
			end
		else
			puts "And the winner is......"
			sleep(2)
			winner.each do |player, score|
				puts player
			end
		end
		puts "Press enter to end game."
		gets
	end
end

