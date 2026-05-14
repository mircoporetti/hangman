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
    if MapSet.member?(game.guesses, letter) do
      {:error, :already_guessed}
    else
      updated_guesses = MapSet.put(game.guesses, letter)
      updated_game = %{game | guesses: updated_guesses}
      {:ok, %{updated_game | state: determine_state(updated_game)}}
    end
  end

  def guess(%__MODULE__{}, _letter) do
    {:error, :game_over}
  end

  def wrong_guesses_count(%__MODULE__{} = game) do
    game.guesses
    |> Enum.reject(&MapSet.member?(word_letters(game), &1))
    |> length()
  end

  defp determine_state(%__MODULE__{guesses: guesses, max_wrong_guesses: max} = game) do
    cond do
      MapSet.subset?(word_letters(game), guesses) ->
        :won

      wrong_guesses_count(game) >= max ->
        :lost

      true ->
        :playing
    end
  end

  defp word_letters(%__MODULE__{word: word}) do
    word |> String.graphemes() |> MapSet.new()
  end
end
