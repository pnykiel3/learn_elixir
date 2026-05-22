defmodule ShortlinkWeb.RedirectController do
  use ShortlinkWeb, :controller
  alias Shortlink.Urls

  def redirect_hash(conn, %{"hash" => hash}) do

    case Urls.get_link_by_hash(hash) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Link does not exist"})

      link ->
        Urls.update_link(link, %{"clicks" => link.clicks + 1})
        conn
        |> redirect(external: link.original_url)
    end
  end
end
