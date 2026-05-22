defmodule Shortlink.UrlsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Shortlink.Urls` context.
  """

  @doc """
  Generate a link.
  """
  def link_fixture(attrs \\ %{}) do
    {:ok, link} =
      attrs
      |> Enum.into(%{
        clicks: 42,
        hash: "some hash",
        original_url: "some original_url"
      })
      |> Shortlink.Urls.create_link()

    link
  end
end
