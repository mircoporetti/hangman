defmodule Hangman.Game do
  @max_wrong_guesses 7

  defstruct [:word, :guesses, :max_wrong_guesses, :state]

  def new(word) do
    %__MODULE__{
      word: word,
      guesses: MapSet.new(),
      max_wrong_guesses: @max_wrong_guesses,
      state: :playing
    }
  end
end
