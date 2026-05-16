defmodule Hangman.WordProvider.FileProvider do
  @behaviour Hangman.WordProvider

  @words_file Path.join(:code.priv_dir(:hangman), "words.txt")
  @words @words_file
         |> File.read!()
         |> String.split("\n", trim: true)

  @impl true
  def random_word do
    Enum.random(@words)
  end
end
