defmodule Hangman.GameTest do
  use ExUnit.Case, async: true

  alias Hangman.Game

  describe "new/1" do
    test "creates a new game with the given word" do
      game = Game.new("elixir")

      assert game.word == "elixir"
      assert game.guesses == MapSet.new()
      assert game.max_wrong_guesses == 7
      assert game.state == :playing
    end
  end
end
