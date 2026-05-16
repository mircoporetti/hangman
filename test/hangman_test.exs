defmodule HangmanTest do
  use ExUnit.Case, async: true

  import Mox

  setup :verify_on_exit!

  setup do
    Hangman.WordProvider.Mock
    |> expect(:random_word, fn -> "elixir" end)

    game = Hangman.start_game()
    %{game: game}
  end

  describe "start_game/0" do
    test "creates a new game with a word from the provider" do
      Hangman.WordProvider.Mock
      |> expect(:random_word, fn -> "word" end)

      game = Hangman.start_game()

      assert game.word == "word"
      assert game.state == :playing
    end
  end

  describe "guess/2" do
    test "the player can guess a letter that is in the word", %{game: game} do
      {:ok, game} = Hangman.guess(game, "e")

      assert game.state == :playing
    end

    test "a wrong guess counts as a mistake", %{game: game} do
      {:ok, game} = Hangman.guess(game, "z")

      assert Hangman.wrong_guesses_count(game) == 1
      assert game.state == :playing
    end

    test "the player wins when all letters are guessed" do
      Hangman.WordProvider.Mock
      |> expect(:random_word, fn -> "hi" end)

      game = Hangman.start_game()

      {:ok, game} = Hangman.guess(game, "h")
      {:ok, game} = Hangman.guess(game, "i")

      assert game.state == :won
    end

    test "the player loses after too many wrong guesses", %{game: game} do
      letters = ["a", "b", "c", "d", "f", "g", "j"]

      game =
        Enum.reduce(letters, game, fn letter, acc ->
          {:ok, updated} = Hangman.guess(acc, letter)
          updated
        end)

      assert game.state == :lost
    end

    test "the player cannot guess when the game is over" do
      Hangman.WordProvider.Mock
      |> expect(:random_word, fn -> "hi" end)

      game = Hangman.start_game()
      {:ok, game} = Hangman.guess(game, "h")
      {:ok, game} = Hangman.guess(game, "i")

      assert {:error, :game_over} = Hangman.guess(game, "z")
    end

    test "the player cannot guess the same letter twice", %{game: game} do
      {:ok, game} = Hangman.guess(game, "e")

      assert {:error, :already_guessed} = Hangman.guess(game, "e")
    end
  end

  describe "revealed_word/1" do
    test "shows underscores for letters not yet guessed", %{game: game} do
      assert Hangman.revealed_word(game) == ["_", "_", "_", "_", "_", "_"]
    end

    test "reveals correctly guessed letters", %{game: game} do
      {:ok, game} = Hangman.guess(game, "i")

      assert Hangman.revealed_word(game) == ["_", "_", "i", "_", "i", "_"]
    end
  end
end
