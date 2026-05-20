defmodule Hangman.Game.State do
  defstruct [:word, :guesses, :max_wrong_guesses, :state]
end
