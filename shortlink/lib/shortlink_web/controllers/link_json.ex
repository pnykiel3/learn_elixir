defmodule ShortlinkWeb.LinkJSON do
  alias Shortlink.Urls.Link

  @doc """
  Renders a list of links.
  """
  def index(%{links: links}) do
    %{data: for(link <- links, do: data(link))}
  end

  @doc """
  Renders a single link.
  """
  def show(%{link: link}) do
    %{data: data(link)}
  end

  defp data(%Link{} = link) do
    %{
      id: link.id,
      original_url: link.original_url,
      hash: link.hash,
      clicks: link.clicks
    }
  end
end
