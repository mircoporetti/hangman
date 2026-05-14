defmodule Hangman.WordProvider do
  @callback random_word() :: String.t()

  def random_word do
    impl().random_word()
  end

  defp impl do
    Application.get_env(:hangman, :word_provider, Hangman.WordProvider.FileProvider)
  end
end
