defmodule TicTacToeBackend.Repo do
  use Ecto.Repo,
    otp_app: :tic_tac_toe_backend,
    adapter: Ecto.Adapters.Postgres
end
