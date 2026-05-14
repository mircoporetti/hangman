defmodule HangmanWeb.Drawing do
  def render(wrong_guesses) do
    frames()
    |> Enum.at(wrong_guesses)
  end

  defp frames do
    [
      """

      
      
      
      
      
      =========\
      """,
      """
        |
        |
        |
        |
        |
        |
      =========\
      """,
      """
        +---+
        |
        |
        |
        |
        |
      =========\
      """,
      """
        +---+
        |   |
        |
        |
        |
        |
      =========\
      """,
      """
        +---+
        |   |
        |   O
        |
        |
        |
      =========\
      """,
      """
        +---+
        |   |
        |   O
        |   |
        |
        |
      =========\
      """,
      """
        +---+
        |   |
        |   O
        |  /|\\
        |
        |
      =========\
      """,
      """
        +---+
        |   |
        |   O
        |  /|\\
        |  / \\
        |
      =========\
      """
    ]
  end
end
