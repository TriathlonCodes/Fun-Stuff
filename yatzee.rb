require_relative 'game_class'

class Yatzee
	def initialize
		die1 = Die.new(6)
		die2 = Die.new(6)
		die3 = Die.new(6)
		die4 = Die.new(6)
		die5 = Die.new(6)
		@dice = [die1, die2, die3, die4, die5]
	end
	attr_reader :die_values
	def play
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
	
	def second_roll
		puts "Which dice would you like to re-roll? (numbers only separated by a space or 'none' please)"
		dice_to_reroll = gets.chomp.split(" ")
		if dice_to_reroll == ["none"]
			return
		end
		dice_to_reroll.map! {|die_num| die_num.to_i}
		raise ArgumentError.new("numbers 1-5 only please") unless dice_to_reroll.max <= 5
		dice_to_reroll.each do |die_num|
			@die_values[die_num-1] = @dice[die_num-1].roll
		end
		p @die_values
	end
	def third_roll
		puts "Which dice would you like to re-roll? (numbers only separated by a space or 'none' please)"
		dice_to_reroll = gets.chomp.split(" ")
		if dice_to_reroll == ["none"]
			return
		end
		dice_to_reroll.map! {|die_num| die_num.to_i}
		raise ArgumentError.new("numbers 1-5 only please") unless dice_to_reroll.max <= 5
		dice_to_reroll.each do |die_num|
			@die_values[die_num-1] = @dice[die_num-1].roll
		end
		p @die_values
	end
	def evaluate
		if yatzee? == true
			puts "Yatzee!"
		elsif straight? == true
			puts "Straight!"
		elsif full_house? == true
			puts "Full house!"
		elsif four_of_a_kind? == true
			puts "Four of a kind!"
		elsif three_of_a_kind? == true
			puts "Three of a kind!"
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
end

stephanie = Yatzee.new

stephanie.play
