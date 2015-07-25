Games = new.Class

def initialize(type)
	type = {card, dice, letter, number}
end
def letter_game	
	prng = Random.new
	number = prng.rand(1..26)
	letter = {
		1 => "A",
		2 => "B",
		3 => "C",
		4 => "D",
		5 => "E",
		6 => "F",
		7 => "G",
		8 => "H",
		9 => "I",
		10 => "J",
		11 => "K",
		12 => "L",
		13 => "M",
		14 => "N",
		15 => "O",
		16 => "P",
		17 => "Q",
		18 => "R",
		19 => "S",
		20 => "T",
		21 => "U",
		22 => "V",
		23 => "W",
		24 => "X",
		25 => "Y",
		26 => "Z"
	}
	right_letter = letter[number]
	puts "Which letter would you like to select?"
	guess = gets.chomp.upcase
	while right_letter != guess
		puts "Sorry, that was incorrect. Try again"
		puts "Which letter would you like to select?"
		guess = gets.chomp.upcase
		break if guess == "QUIT"
	end
	puts "Congratulations! You guessed right! The secret letter was #{right_letter}." 
end

letter_game
end