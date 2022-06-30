defmodule TicTacToeBackend.GamesTest do
  use TicTacToeBackend.DataCase

  alias TicTacToeBackend.Games

  describe "games" do
    alias TicTacToeBackend.Games.Game

    import TicTacToeBackend.GamesFixtures

    @invalid_attrs %{available_moves: nil, best_score_move: nil, board: nil, current_player: nil, maximizer: nil, player_1_mark: nil, player_1_moves: nil, player_1_type: nil, player_2_mark: nil, player_2_moves: nil, player_2_type: nil, win: nil, winner: nil}

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Games.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Games.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{available_moves: [], best_score_move: %{}, board: %{}, current_player: 42, maximizer: 42, player_1_mark: "some player_1_mark", player_1_moves: [], player_1_type: "some player_1_type", player_2_mark: "some player_2_mark", player_2_moves: [], player_2_type: "some player_2_type", win: true, winner: 42}

      assert {:ok, %Game{} = game} = Games.create_game(valid_attrs)
      assert game.available_moves == []
      assert game.best_score_move == %{}
      assert game.board == %{}
      assert game.current_player == 42
      assert game.maximizer == 42
      assert game.player_1_mark == "some player_1_mark"
      assert game.player_1_moves == []
      assert game.player_1_type == "some player_1_type"
      assert game.player_2_mark == "some player_2_mark"
      assert game.player_2_moves == []
      assert game.player_2_type == "some player_2_type"
      assert game.win == true
      assert game.winner == 42
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Games.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()
      update_attrs = %{available_moves: [], best_score_move: %{}, board: %{}, current_player: 43, maximizer: 43, player_1_mark: "some updated player_1_mark", player_1_moves: [], player_1_type: "some updated player_1_type", player_2_mark: "some updated player_2_mark", player_2_moves: [], player_2_type: "some updated player_2_type", win: false, winner: 43}

      assert {:ok, %Game{} = game} = Games.update_game(game, update_attrs)
      assert game.available_moves == []
      assert game.best_score_move == %{}
      assert game.board == %{}
      assert game.current_player == 43
      assert game.maximizer == 43
      assert game.player_1_mark == "some updated player_1_mark"
      assert game.player_1_moves == []
      assert game.player_1_type == "some updated player_1_type"
      assert game.player_2_mark == "some updated player_2_mark"
      assert game.player_2_moves == []
      assert game.player_2_type == "some updated player_2_type"
      assert game.win == false
      assert game.winner == 43
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Games.update_game(game, @invalid_attrs)
      assert game == Games.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Games.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Games.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Games.change_game(game)
    end
  end
end
