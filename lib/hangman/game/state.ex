defmodule Hangman.Game.State do
  defstruct [:word, :max_wrong_guesses,
  guesses: MapSet.new(), 
  state: :playing]
end
