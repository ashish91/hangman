require_relative './hangman_response.rb'

class Hangman
	def initialize(phrase:, total_chances: 6)
		@total_chances = total_chances
		@remaining_chances = total_chances

		@hashed_phrase = memoize_phrase_as_hash(phrase.downcase)
		@incorrect_letters = {}
		@correct_letters = {}
	end

	def guess(letter)
		letter = letter.downcase

		if !valid_letter?(letter)
			response = :invalid_letter
		elsif no_chances_remaining?
			response = :game_lost
		elsif all_letters_guessed?
			response = :game_won
		elsif @correct_letters[letter] || @incorrect_letters[letter]
			response = :already_guessed
		elsif @hashed_phrase[letter] == true
			response = :correct_guess
			@correct_letters[letter] = true
			@hashed_phrase.delete(letter)

			response = :game_won if all_letters_guessed?
		else
			response = :incorrect_guess
			@incorrect_letters[letter] = true
			@remaining_chances -= 1

			response = :game_lost if no_chances_remaining?
		end

		HangmanResponse.new(
				correct_letters: @correct_letters,
				incorrect_letters: @incorrect_letters,
				total_chances: @total_chances,
				remaining_chances: @remaining_chances,
				response: response
		)
	end

	def game_concluded?
		no_chances_remaining? || all_letters_guessed?
	end

	private
	def valid_letter?(letter)
		letter.match(/^[a-zA-Z]{1}$/)
	end

	def no_chances_remaining?
		@remaining_chances == 0
	end

	def memoize_phrase_as_hash(phrase)
		hashed_phrase = {}
		phrase.split('').each do |letter|
			next if is_space?(letter)

			hashed_phrase[letter] = true
		end
		hashed_phrase
	end

	def all_letters_guessed?
		@hashed_phrase.keys.length == 0
	end

	def is_space?(letter)
		letter.strip.length == 0
	end
end