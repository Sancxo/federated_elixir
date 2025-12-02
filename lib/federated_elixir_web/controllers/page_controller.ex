defmodule FederatedElixirWeb.PageController do
  use FederatedElixirWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
