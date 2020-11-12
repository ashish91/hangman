class HangmanResponse
	attr_reader :correct_letters, :incorrect_letters, :total_chances, :remaining_chances, :response

	def initialize(correct_letters:, incorrect_letters:, total_chances:, remaining_chances:, response:)
		@correct_letters = correct_letters
		@incorrect_letters = incorrect_letters
		@total_chances = total_chances
		@remaining_chances = remaining_chances
		@response = response
	end
end