require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @word = params[:word].upcase.split("")
    @grid = params[:letters].split(" ")
   if valid_word(@word) == false
    puts "Sorry but #{@word} does not seem to be valid English word"
   elsif in_grid(@word, @grid) == false
    puts "Sorry but #{@word} can't be built out of #{@letters}"
   elsif valid_word(@word) && in_grid(@word, @grid)
    puts "Congratulations! #{@word} is a valid word!"
   end
  end

  private

  def in_grid (word, grid)
    word.each_with_index do |letter, index|
      other_letters = grid.delete_at(index) if grid.include(letter)
    end
    grid.length - other_letters.lenght == word.lenght
  end

  def valid_word(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    word = JSON.parse(word_serialized)
    word['found']
  end
end



# Le mot ne peut pas être créé à partir de la grille d’origine.
# Le mot est valide d’après la grille, mais ce n’est pas un mot anglais valide.
# Le mot est valide d’après la grille et est un mot anglais valide.
