require 'pdf-reader'

shared_phrases = []
phrase_len = [2,3]

# 1/4 chance
def random_truth(lean=4)
	truth = [true] * (lean-1)

	(truth + [false]).sample
end

def valid_word(word)
	word.strip.length != 0 && word.match(/^[a-zA-Z\s]+$/)
end

def read_pdf(book)
	text = ''

	reader = PDF::Reader.new(book)
	reader.pages.each do |page|
	  text += ' ' + page.text
	end

	text
end

shared_available_books = Dir["/Users/agaur/side-projects/hangman/books/*"]

threads = []
2.times {
  threads << Thread.new do
  	book = shared_available_books.pop
		text = read_pdf(book)
		words = text.split(' ')

		len = phrase_len.sample
		curr_phrase = ''

  	words.each do |word|
			if len == 0
				len = phrase_len.sample
				shared_phrases.push(curr_phrase)
				curr_phrase = ''
			end

			if valid_word(word) && random_truth
				curr_phrase += ' ' + word
				len -= 1
			else
				curr_phrase = ''
				len = phrase_len.sample
			end
		end
  end
}

threads.each(&:join)
puts shared_phrases.length
File.open("./phrases.txt", "w+") do |f|
  f.puts(shared_phrases)
end
