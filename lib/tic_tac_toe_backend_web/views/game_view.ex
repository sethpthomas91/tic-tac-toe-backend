defmodule TicTacToeBackendWeb.GameView do
  use TicTacToeBackendWeb, :view
  alias TicTacToeBackendWeb.GameView

  def render("index.json", %{games: games}) do
    %{data: render_many(games, GameView, "game.json")}
  end

  def render("show.json", %{game: game}) do
    %{data: render_one(game, GameView, "game.json")}
  end

  def render("game.json", %{game: game}) do
    %{
      id: game.id,
      available_moves: game.available_moves,
      won: game.won,
      tied: game.tied,
      winner: game.winner,
      player_1_moves: game.player_1_moves,
      player_2_moves: game.player_2_moves,
      player_1_mark: game.player_1_mark,
      player_2_mark: game.player_2_mark,
      current_player: game.current_player,
      player_1_type: game.player_1_type,
      player_2_type: game.player_2_type,
      maximizer: game.maximizer,
      best_score_move: game.best_score_move,
      board: game.board
    }
  end
end
