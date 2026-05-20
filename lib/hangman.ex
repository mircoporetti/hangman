defmodule Hangman do
  alias Hangman.Game
  alias Hangman.Game.State

  defp word_provider do
    Application.fetch_env!(:hangman, :word_provider)
  end

  def start_game do
    word = word_provider().random_word()
    Game.new(word)
  end

  def guess(%State{} = state, letter) do
    Game.guess(state, letter)
  end

  def revealed_word(%State{} = state) do
    Game.revealed_word(state)
  end

  def wrong_guesses_count(%State{} = state) do
    Game.wrong_guesses_count(state)
  end
end
