defmodule TicTacToeBackend.Repo.Migrations.CreateGames do
  use Ecto.Migration
  def change do
    create table(:games) do
      add :available_moves, {:array, :integer}
      add :won, :boolean, default: false, null: false
      add :tied, :boolean, default: false, null: false
      add :winner, :integer
      add :player_1_moves, {:array, :integer}
      add :player_2_moves, {:array, :integer}
      add :player_1_mark, :string
      add :player_2_mark, :string
      add :current_player, :integer
      add :player_1_type, :string
      add :player_2_type, :string
      add :maximizer, :integer
      add :best_score_move, :map
      add :board, :map

      timestamps()
    end
  end
end
