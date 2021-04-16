defmodule MangarooWeb.Graph.Schema.Content.Manga.QueryTest do
  use MangarooWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "mangas" do
    test "returns all Manga records", %{conn: conn} do
      Enum.each(0..4, fn _ ->
        manga_fixture()
      end)

      query = """
        query ListMangas {
          mangas {
            id
            name
            author
            artist
            status
            demographic
            isHentai
            description
          }
        }
      """

      response =
        conn
        |> post(
          "/api",
          query_skeleton(query, "ListMangas", nil)
        )
        |> json_response(200)

      assert Enum.count(response["data"]["mangas"]) == 5
    end
  end

  describe "manga" do
    test "returns the Manga record of the given ID", %{conn: conn} do
      manga = manga_fixture()

      Enum.each(0..4, fn _ ->
        chapter_fixture(manga)
      end)

      query = """
        query GetManga($id: ID!) {
          manga(id: $id) {
            id
            name
            author
            artist
            status
            demographic
            isHentai
            description
            chapters {
              id
              name
              mangaId
            }
          }
        }
      """

      variables = %{id: manga.id}

      response =
        conn
        |> post(
          "/api",
          query_skeleton(query, "GetManga", variables)
        )
        |> json_response(200)

      chapter = Enum.at(response["data"]["manga"]["chapters"], 0)

      assert response["data"]["manga"]["artist"] == "Factory Manga Artist"
      assert response["data"]["manga"]["author"] == "Factory Manga Author"
      assert response["data"]["manga"]["demographic"] == "shounen"
      assert response["data"]["manga"]["description"] == "Factory Manga Description"
      assert response["data"]["manga"]["id"]
      assert response["data"]["manga"]["isHentai"] == false
      assert response["data"]["manga"]["name"] == "Factory Manga Name"
      assert response["data"]["manga"]["status"] == "ongoing"
      assert Enum.count(response["data"]["manga"]["chapters"]) == 5
      assert chapter["id"]
      assert chapter["name"] == "Factory Chapter Name"
      assert chapter["mangaId"] == "#{manga.id}"
    end
  end
end
