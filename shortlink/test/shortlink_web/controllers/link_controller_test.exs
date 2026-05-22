defmodule ShortlinkWeb.LinkControllerTest do
  use ShortlinkWeb.ConnCase

  import Shortlink.UrlsFixtures
  alias Shortlink.Urls.Link

  @create_attrs %{
    hash: "some hash",
    original_url: "some original_url",
    clicks: 42
  }
  @update_attrs %{
    hash: "some updated hash",
    original_url: "some updated original_url",
    clicks: 43
  }
  @invalid_attrs %{hash: nil, original_url: nil, clicks: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all links", %{conn: conn} do
      conn = get(conn, ~p"/api/links")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/links", link: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/links/#{id}")

      assert %{
               "id" => ^id,
               "clicks" => 42,
               "hash" => "some hash",
               "original_url" => "some original_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/links", link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update link" do
    setup [:create_link]

    test "renders link when data is valid", %{conn: conn, link: %Link{id: id} = link} do
      conn = put(conn, ~p"/api/links/#{link}", link: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/links/#{id}")

      assert %{
               "id" => ^id,
               "clicks" => 43,
               "hash" => "some updated hash",
               "original_url" => "some updated original_url"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, link: link} do
      conn = put(conn, ~p"/api/links/#{link}", link: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete link" do
    setup [:create_link]

    test "deletes chosen link", %{conn: conn, link: link} do
      conn = delete(conn, ~p"/api/links/#{link}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/links/#{link}")
      end
    end
  end

  defp create_link(_) do
    link = link_fixture()

    %{link: link}
  end
end
