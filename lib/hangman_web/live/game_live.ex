defmodule HangmanWeb.GameLive do
  use HangmanWeb, :live_view

  alias Hangman.Game

  @word "elixir"

  @impl true
  def mount(_params, _session, socket) do
    game = Game.new(@word)

    {:ok, assign(socket, game: game)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto mt-10 text-center">
      <h1 class="text-3xl font-bold mb-6">Hangman</h1>

      <div class="text-4xl font-mono tracking-widest mb-8">
        <%= Enum.join(Game.revealed_word(@game), " ") %>
      </div>
    </div>
    """
  end
end
