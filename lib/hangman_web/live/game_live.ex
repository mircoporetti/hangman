defmodule HangmanWeb.GameLive do
  use HangmanWeb, :live_view

  alias Hangman.Game

  @word "elixir"

  @impl true
  def mount(_params, _session, socket) do
    game = Game.new(@word)

    {:ok, assign(socket, game: game, message: nil)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div class="max-w-lg mx-auto mt-10 text-center">
      <h1 class="text-3xl font-bold mb-6">Hangman</h1>

      <div class="text-4xl font-mono tracking-widest mb-8">
        <%= Enum.join(Game.revealed_word(@game), " ") %>
      </div>

      <p class="mb-4 text-lg">
        Wrong guesses: <%= Game.wrong_guesses_count(@game) %> / <%= @game.max_wrong_guesses %>
      </p>

      <%= if @game.state == :won do %>
        <p class="text-2xl font-bold text-green-600 mb-4">You won!</p>
      <% end %>

      <%= if @game.state == :lost do %>
        <p class="text-2xl font-bold text-red-600 mb-4">You lost! The word was: <%= @game.word %></p>
      <% end %>

      <%= if @message do %>
        <p class="text-yellow-600 mb-4"><%= @message %></p>
      <% end %>

      <form phx-submit="guess" class="mb-6">
        <input
          type="text"
          name="letter"
          maxlength="1"
          placeholder=""
          class="border rounded px-3 py-2 text-center text-lg w-20"
          autocomplete="off"
        />
        <button type="submit" class="ml-2 bg-blue-500 text-white px-4 py-2 rounded">
          Guess
        </button>
      </form>
    </div>
    """
  end

  @impl true
  def handle_event("guess", %{"letter" => letter}, socket) do
    game = socket.assigns.game

    case Game.guess(game, String.downcase(letter)) do
      {:ok, updated_game} ->
        {:noreply, assign(socket, game: updated_game, message: nil)}

      {:error, :already_guessed} ->
        {:noreply, assign(socket, message: "Already guessed")}

      {:error, _reason} ->
        {:noreply, socket}
    end
  end
end
