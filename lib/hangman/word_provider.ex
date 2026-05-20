defmodule Hangman.WordProvider do
  @callback random_word() :: String.t()
end
