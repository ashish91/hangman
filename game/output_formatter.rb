class OutputFormatter
	def initialize(phrase)
		@phrase = phrase
	end

	def start
		print_all_empties
		guess_letter
	end

	def invalid_letter(hangman_response)
		puts
		negate
		print_phrase(hangman_response)
		print_status(hangman_response)

		puts
		puts 'Letter not allowed'
		puts 'Only single english letter(a-z) is allowed'
		guess_letter
	end

	def game_lost(hangman_response)
		puts
		negate
		print_phrase(hangman_response)
		print_status(hangman_response)

		puts
		puts "The phrase was '#{@phrase}'"
		puts 'Sorry, you lost the game.'
	end

	def game_won(hangman_response)
		puts
		appreciate
		print_phrase(hangman_response)
		print_status(hangman_response)
		puts
		puts 'You got it! Great job!'
	end

	def already_guessed(hangman_response)
		puts
		print_phrase(hangman_response)
		print_status(hangman_response)
		puts
		puts 'You already guessed that one!'
		guess_letter
	end

	def correct_guess(hangman_response)
		puts
		appreciate
		print_phrase(hangman_response)
		print_status(hangman_response)
		guess_letter
	end

	def incorrect_guess(hangman_response)
		puts
		negate
		print_phrase(hangman_response)
		print_status(hangman_response)
		guess_letter
	end

	private
	def print_all_empties
		@phrase.each_char do |letter|
			if is_space?(letter)
				print ' '
			else
				print '_'
			end
		end
		puts
	end

	def print_phrase(hangman_response)
		@phrase.each_char do |letter|
			if is_space?(letter)
				print ' '
			elsif hangman_response.correct_letters[letter]
				print letter
			else
				print '_'
			end
		end
		puts
	end

	def print_status(hangman_response)
		puts "Correct letters: #{hangman_response.correct_letters.keys}"
		puts "Incorrect letters: #{hangman_response.incorrect_letters.keys}"
		puts "Chances: #{hangman_response.remaining_chances}/#{hangman_response.total_chances}"
	end

	def guess_letter
		puts
		print 'Guess a letter: '
	end

	def negate
		puts 'Nope!'
	end

	def appreciate
		puts 'Good!'
	end

	def is_space?(letter)
		letter.strip.length == 0
	end

end