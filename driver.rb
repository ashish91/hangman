require_relative './game/hangman.rb'
require_relative './game/output_formatter.rb'

phrase =   File.readlines("phrases.txt").sample.strip.downcase
hangman = Hangman.new(phrase: phrase)
system("clear")
output_formatter = OutputFormatter.new(phrase)
output_formatter.start

while (input = $stdin.gets.chomp)
	system("clear")
	response = hangman.guess(input)
	output_formatter.send(response.response, response)

	break if hangman.game_concluded?
end