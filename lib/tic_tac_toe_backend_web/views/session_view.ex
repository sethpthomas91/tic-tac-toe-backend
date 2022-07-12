defmodule TicTacToeBackendWeb.SessionView do
  use TicTacToeBackendWeb, :view

  def render("token.json", %{access_token: access_token}) do
    %{access_token: access_token}
  end

  
end
