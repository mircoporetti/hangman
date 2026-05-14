defmodule HangmanWeb.GameLiveTest do
  use HangmanWeb.ConnCase

  import Phoenix.LiveViewTest

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
  end
end
