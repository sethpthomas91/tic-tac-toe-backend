defmodule TicTacToeBackendWeb.PageController do
  use TicTacToeBackendWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
