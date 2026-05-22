defmodule Shortlink.UrlsTest do
  use Shortlink.DataCase

  alias Shortlink.Urls

  describe "links" do
    alias Shortlink.Urls.Link

    import Shortlink.UrlsFixtures

    @invalid_attrs %{hash: nil, original_url: nil, clicks: nil}

    test "list_links/0 returns all links" do
      link = link_fixture()
      assert Urls.list_links() == [link]
    end

    test "get_link!/1 returns the link with given id" do
      link = link_fixture()
      assert Urls.get_link!(link.id) == link
    end

    test "create_link/1 with valid data creates a link" do
      valid_attrs = %{hash: "some hash", original_url: "some original_url", clicks: 42}

      assert {:ok, %Link{} = link} = Urls.create_link(valid_attrs)
      assert link.hash == "some hash"
      assert link.original_url == "some original_url"
      assert link.clicks == 42
    end

    test "create_link/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Urls.create_link(@invalid_attrs)
    end

    test "update_link/2 with valid data updates the link" do
      link = link_fixture()
      update_attrs = %{hash: "some updated hash", original_url: "some updated original_url", clicks: 43}

      assert {:ok, %Link{} = link} = Urls.update_link(link, update_attrs)
      assert link.hash == "some updated hash"
      assert link.original_url == "some updated original_url"
      assert link.clicks == 43
    end

    test "update_link/2 with invalid data returns error changeset" do
      link = link_fixture()
      assert {:error, %Ecto.Changeset{}} = Urls.update_link(link, @invalid_attrs)
      assert link == Urls.get_link!(link.id)
    end

    test "delete_link/1 deletes the link" do
      link = link_fixture()
      assert {:ok, %Link{}} = Urls.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Urls.get_link!(link.id) end
    end

    test "change_link/1 returns a link changeset" do
      link = link_fixture()
      assert %Ecto.Changeset{} = Urls.change_link(link)
    end
  end
end
