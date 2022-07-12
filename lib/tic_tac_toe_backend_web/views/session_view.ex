defmodule TicTacToeBackendWeb.SessionView do
  use TicTacToeBackendWeb, :view
  alias TicTacToeBackendWeb.SessionView

  def render("token.json", %{access_token: access_token}) do
    %{access_token: access_token}
  end

end
