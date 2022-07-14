defmodule TicTacToeBackend.GameDataFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TicTacToeBackend.GameData` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
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
        tied: true,
        winner: 42,
        won: true
      })
      |> TicTacToeBackend.GameData.create_game()

    game
  end
end
