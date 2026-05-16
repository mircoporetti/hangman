defmodule Hangman do
  alias Hangman.Game
  alias Hangman.WordProvider

  def start_game do
    word = WordProvider.random_word()
    Game.new(word)
  end

  def guess(%Game{} = game, letter) do
    Game.guess(game, letter)
  end

  def revealed_word(%Game{} = game) do
    Game.revealed_word(game)
  end

  def wrong_guesses_count(%Game{} = game) do
    Game.wrong_guesses_count(game)
  end
end
