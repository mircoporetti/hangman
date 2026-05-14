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

  def guess(%__MODULE__{state: :playing} = game, letter) do
    updated_guesses = MapSet.put(game.guesses, letter)
    {:ok, %{game | guesses: updated_guesses}}
  end

  def wrong_guesses_count(%__MODULE__{word: word, guesses: guesses}) do
    word_letters = word |> String.graphemes() |> MapSet.new()

    guesses
    |> Enum.reject(&MapSet.member?(word_letters, &1))
    |> length()
  end
end
