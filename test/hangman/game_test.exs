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

  describe "guess/2" do
    test "the player can guess a letter that is in the word" do
      game = Game.new("elixir")

      {:ok, game} = Game.guess(game, "e")

      assert MapSet.member?(game.guesses, "e")
      assert game.state == :playing
    end

    test "a wrong guess counts as a mistake" do
      game = Game.new("elixir")

      {:ok, game} = Game.guess(game, "z")

      assert MapSet.member?(game.guesses, "z")
      assert Game.wrong_guesses_count(game) == 1
      assert game.state == :playing
    end
  end
end
