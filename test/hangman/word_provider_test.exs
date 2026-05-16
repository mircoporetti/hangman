defmodule Hangman.WordProvider.FileProviderTest do
  use ExUnit.Case, async: true

  alias Hangman.WordProvider.FileProvider

  describe "random_word/0" do
    test "returns a non-empty string" do
      word = FileProvider.random_word()

      assert is_binary(word)
      assert String.length(word) > 0
    end

    test "returns a lowercase word between 5 and 8 characters" do
      word = FileProvider.random_word()

      assert word =~ ~r/^[a-z]{5,8}$/
    end
  end
end
