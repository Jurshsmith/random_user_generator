defmodule RandomUserGeneratorWeb.PageController do
  use RandomUserGeneratorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
