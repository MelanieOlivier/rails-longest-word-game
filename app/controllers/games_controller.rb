require "open-uri"

class GamesController < ApplicationController
  def new
    alphabet_array = [*'A'...'Z']
    @letters = alphabet_array.sample(10)
    # @letters = @letters_to_be_built.each { |letter| puts "#{letter}" }
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
