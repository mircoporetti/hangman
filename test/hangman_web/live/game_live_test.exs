defmodule HangmanWeb.GameLiveTest do
  use HangmanWeb.ConnCase

  import Phoenix.LiveViewTest
  import Mox

  setup :verify_on_exit!

  setup do
    stub(Hangman.WordProvider.Mock, :random_word, fn -> "elixir" end)
    :ok
  end

  describe "game page" do
    test "shows the word as underscores on start", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert render(view) =~ "_ _ _ _ _ _"
    end

    test "the player can guess a correct letter", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      html = view |> element("form") |> render_submit(%{"letter" => "e"})

      assert html =~ "e _ _ _ _ _"
    end

    test "a wrong guess shows the mistake count", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      html = view |> element("form") |> render_submit(%{"letter" => "z"})

      assert html =~ "Wrong guesses: 1 / 7"
    end

    test "the player sees a victory message when all letters are guessed", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      for letter <- ["e", "l", "i", "x", "r"] do
        view |> element("form") |> render_submit(%{"letter" => letter})
      end

      assert render(view) =~ "You won!"
    end

    test "the player sees a defeat message after too many wrong guesses", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      for letter <- ["a", "b", "c", "d", "f", "g", "j"] do
        view |> element("form") |> render_submit(%{"letter" => letter})
      end

      html = render(view)
      assert html =~ "You lost!"
      assert html =~ "elixir"
    end

    test "the player sees a message when guessing an already tried letter", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      view |> element("form") |> render_submit(%{"letter" => "e"})
      html = view |> element("form") |> render_submit(%{"letter" => "e"})

      assert html =~ "Already guessed"
    end

    test "the form is hidden when the game is over", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      for letter <- ["e", "l", "i", "x", "r"] do
        view |> element("form") |> render_submit(%{"letter" => letter})
      end

      refute render(view) =~ "<form"
    end

    test "the player can start a new game after winning", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      for letter <- ["e", "l", "i", "x", "r"] do
        view |> element("form") |> render_submit(%{"letter" => letter})
      end

      html = view |> element("button", "Play again") |> render_click()

      assert html =~ "_ _ _ _ _ _"
    end

    test "the player can see which letters have been guessed", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      view |> element("form") |> render_submit(%{"letter" => "e"})
      view |> element("form") |> render_submit(%{"letter" => "z"})

      html = render(view)
      assert html =~ "Guessed: e, z"
    end
  end
end
