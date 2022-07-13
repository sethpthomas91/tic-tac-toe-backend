defmodule TicTacToeBackend.GameData.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :available_moves, {:array, :integer}
    field :best_score_move, :map
    field :board, :map
    field :current_player, :integer
    field :maximizer, :integer
    field :player_1_mark, :string
    field :player_1_moves, {:array, :integer}
    field :player_1_type, :string
    field :player_2_mark, :string
    field :player_2_moves, {:array, :integer}
    field :player_2_type, :string
    field :tied, :boolean, default: false
    field :winner, :integer
    field :won, :boolean, default: false
    belongs_to :user, TicTacToeBackend.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:available_moves, :won, :tied, :winner, :player_1_moves, :player_2_moves, :player_1_mark, :player_2_mark, :current_player, :player_1_type, :player_2_type, :maximizer, :best_score_move, :board])
    |> validate_required([:available_moves, :won, :tied, :winner, :player_1_moves, :player_2_moves, :player_1_mark, :player_2_mark, :current_player, :player_1_type, :player_2_type, :maximizer, :best_score_move, :board])
  end
end
