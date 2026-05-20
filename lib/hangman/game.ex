defmodule Hangman.Game do
  alias Hangman.Game.State

  @max_wrong_guesses 7

  def new(word) do
    %State{
      word: word,
      guesses: MapSet.new(),
      max_wrong_guesses: @max_wrong_guesses,
      state: :playing
    }
  end

  def guess(%State{state: :playing} = state, letter) do
    if MapSet.member?(state.guesses, letter) do
      {:error, :already_guessed}
    else
      updated_guesses = MapSet.put(state.guesses, letter)
      updated_state = %{state | guesses: updated_guesses}
      {:ok, %{updated_state | state: determine_state(updated_state)}}
    end
  end

  def guess(%State{}, _letter) do
    {:error, :game_over}
  end

  def wrong_guesses_count(%State{} = state) do
    state.guesses
    |> Enum.reject(&MapSet.member?(word_letters(state), &1))
    |> length()
  end

  def revealed_word(%State{word: word, guesses: guesses}) do
    word
    |> String.graphemes()
    |> Enum.map(fn letter ->
      if MapSet.member?(guesses, letter), do: letter, else: "_"
    end)
  end

  defp determine_state(%State{guesses: guesses, max_wrong_guesses: max} = state) do
    cond do
      MapSet.subset?(word_letters(state), guesses) ->
        :won

      wrong_guesses_count(state) >= max ->
        :lost

      true ->
        :playing
    end
  end

  defp word_letters(%State{word: word}) do
    word |> String.graphemes() |> MapSet.new()
  end
end
