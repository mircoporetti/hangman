defmodule HangmanWeb.DrawingTest do
  use ExUnit.Case, async: true

  alias HangmanWeb.Drawing

  describe "render/1" do
    test "no wrong guesses shows an empty drawing" do
      assert Drawing.render(0) == """

      
      
      
      
      
      =========\
      """
    end

    test "one wrong guess shows the pole" do
      assert Drawing.render(1) == """
        |
        |
        |
        |
        |
        |
      =========\
      """
    end

    test "two wrong guesses shows the beam" do
      assert Drawing.render(2) == """
        +---+
        |
        |
        |
        |
        |
      =========\
      """
    end

    test "three wrong guesses shows the rope" do
      assert Drawing.render(3) == """
        +---+
        |   |
        |
        |
        |
        |
      =========\
      """
    end

    test "four wrong guesses shows the head" do
      assert Drawing.render(4) == """
        +---+
        |   |
        |   O
        |
        |
        |
      =========\
      """
    end

    test "five wrong guesses shows the body" do
      assert Drawing.render(5) == """
        +---+
        |   |
        |   O
        |   |
        |
        |
      =========\
      """
    end

    test "six wrong guesses shows the arms" do
      assert Drawing.render(6) == """
        +---+
        |   |
        |   O
        |  /|\\
        |
        |
      =========\
      """
    end

    test "seven wrong guesses shows the legs" do
      assert Drawing.render(7) == """
        +---+
        |   |
        |   O
        |  /|\\
        |  / \\
        |
      =========\
      """
    end
  end
end
