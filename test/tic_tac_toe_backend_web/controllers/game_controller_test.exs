defmodule TicTacToeBackendWeb.GameControllerTest do
  use TicTacToeBackendWeb.ConnCase

  import TicTacToeBackend.GamesFixtures

  alias TicTacToeBackend.Games.Game

  @create_attrs %{
    available_moves: [],
    best_score_move: %{},
    board: %{},
    current_player: 42,
    maximizer: 42,
    player_1_mark: "some player_1_mark",
    player_1_moves: [],
    player_1_type: "some player_1_type",
    player_2_mark: "some player_2_mark",
    player_2_moves: [],
    player_2_type: "some player_2_type",
    win: true,
    winner: 42
  }
  @update_attrs %{
    available_moves: [],
    best_score_move: %{},
    board: %{},
    current_player: 43,
    maximizer: 43,
    player_1_mark: "some updated player_1_mark",
    player_1_moves: [],
    player_1_type: "some updated player_1_type",
    player_2_mark: "some updated player_2_mark",
    player_2_moves: [],
    player_2_type: "some updated player_2_type",
    win: false,
    winner: 43
  }
  @invalid_attrs %{available_moves: nil, best_score_move: nil, board: nil, current_player: nil, maximizer: nil, player_1_mark: nil, player_1_moves: nil, player_1_type: nil, player_2_mark: nil, player_2_moves: nil, player_2_type: nil, win: nil, winner: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all games", %{conn: conn} do
      conn = get(conn, Routes.game_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create game" do
    test "renders game when data is valid", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create), game: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.game_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "available_moves" => [],
               "best_score_move" => %{},
               "board" => %{},
               "current_player" => 42,
               "maximizer" => 42,
               "player_1_mark" => "some player_1_mark",
               "player_1_moves" => [],
               "player_1_type" => "some player_1_type",
               "player_2_mark" => "some player_2_mark",
               "player_2_moves" => [],
               "player_2_type" => "some player_2_type",
               "win" => true,
               "winner" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.game_path(conn, :create), game: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update game" do
    setup [:create_game]

    test "renders game when data is valid", %{conn: conn, game: %Game{id: id} = game} do
      conn = put(conn, Routes.game_path(conn, :update, game), game: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.game_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "available_moves" => [],
               "best_score_move" => %{},
               "board" => %{},
               "current_player" => 43,
               "maximizer" => 43,
               "player_1_mark" => "some updated player_1_mark",
               "player_1_moves" => [],
               "player_1_type" => "some updated player_1_type",
               "player_2_mark" => "some updated player_2_mark",
               "player_2_moves" => [],
               "player_2_type" => "some updated player_2_type",
               "win" => false,
               "winner" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, game: game} do
      conn = put(conn, Routes.game_path(conn, :update, game), game: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete game" do
    setup [:create_game]

    test "deletes chosen game", %{conn: conn, game: game} do
      conn = delete(conn, Routes.game_path(conn, :delete, game))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.game_path(conn, :show, game))
      end
    end
  end

  defp create_game(_) do
    game = game_fixture()
    %{game: game}
  end
end
