import GameLogic

defmodule TicTacToeBackendWeb.GameController do
  use TicTacToeBackendWeb, :controller

  alias TicTacToeBackend.GameData
  alias TicTacToeBackend.GameData.Game

  action_fallback TicTacToeBackendWeb.FallbackController

  def index(conn, _params) do
    games = GameData.list_games()
    render(conn, "index.json", games: games)
  end

  def create(conn, %{"game" => game_params}) do
    with {:ok, %Game{} = game} <- GameData.create_game(game_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.game_path(conn, :show, game))
      |> render("show.json", game: game)
    end
  end

  def show(conn, %{"id" => id}) do
    game = GameData.get_game!(id)
    render(conn, "show.json", game: game)
  end

  def update(conn, %{"id" => id, "move" => move}) do
    game = GameData.get_game!(id)
    stripped_game = Map.drop(game, [:__meta__, :__struct__, :inserted_at, :updated_at])
    game_after_move = GameLogic.handle_move(move, stripped_game)
    game_after_win_check = GameLogic.check_for_win(game_after_move)
    game_after_player_change =  GameLogic.change_player(game_after_win_check)
    new_game_data = game_after_player_change
    with {:ok, %Game{} = game} <- GameData.update_game(game, new_game_data) do
      render(conn, "show.json", game: game)
    end
  end

  def delete(conn, %{"id" => id}) do
    game = GameData.get_game!(id)

    with {:ok, %Game{}} <- GameData.delete_game(game) do
      send_resp(conn, :no_content, "")
    end
  end
end
