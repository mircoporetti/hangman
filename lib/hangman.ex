defmodule Hangman do
  alias Hangman.Game
  alias Hangman.WordProvider

  def start_game do
    word = WordProvider.random_word()
    Game.new(word)
  end
end
