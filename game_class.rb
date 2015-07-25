class Player
	def initialize(player_name)
		@player_name = player_name
	end
	@games_played = Hash.new
	attr_accessor :games_played
	attr_reader :player_name
end

class Game
	def intialize
	end
end

class BingoGame < Game
end

class DiceGame #< Game
	def initialize(game)
		@game = game
	end
	valid_games = ["yatzee"]
end
class Die
	def initialize(sides)
		@sides = sides
		raise ArgumentError.new("Die must have positive number of sides") unless sides > 0
	end
	def roll
		rand(1..@sides)
	end
end

# end

class CardGame < Game
end