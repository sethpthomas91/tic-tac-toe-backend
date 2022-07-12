defmodule TicTacToeBackend.Guardian.AuthPipeline do
  @claims %{typ: "access"}

  use Guardian.Plug.Pipeline,
  otp_app: :tic_tac_toe_backend,
  module: TicTacToeBackend.Guardian,
  error_handler: TicTacToeBackend.Guardian.AuthErrorHandler

  plug(Guardian.Plug.VerifyHeader, claims: @claims, scheme: "Bearer")
  plug(Guardian.Plug.EnsureAuthenticated)
  plug(Guardian.Plug.LoadResource, ensure: true)
end
