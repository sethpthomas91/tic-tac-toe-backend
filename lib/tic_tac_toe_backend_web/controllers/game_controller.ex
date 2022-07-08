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

    new_game_data =
      GameLogic.convert_schema_to_map(game)
      |> GameLogic.handle_game_logic(move)

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
