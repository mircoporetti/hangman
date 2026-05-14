defmodule HangmanWeb.GameLiveTest do
  use HangmanWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "game page" do
    test "shows the word as underscores on start", %{conn: conn} do
      {:ok, view, _html} = live(conn, "/")

      assert render(view) =~ "_ _ _ _ _ _"
    end
  end
end
