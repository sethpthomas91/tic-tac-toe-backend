defmodule TicTacToeBackendWeb.UserController do
  use TicTacToeBackendWeb, :controller

  alias TicTacToeBackend.Accounts
  alias TicTacToeBackend.Accounts.User

  action_fallback TicTacToeBackendWeb.FallbackController

  def register(conn, %{"user" => user_params}) do
    with {:ok, user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      |> text("User successfully registered with email:" <> " " <> user.email)
    end
  end
end
