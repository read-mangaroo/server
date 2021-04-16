defmodule MangarooWeb.Graph.Schema.Content.Chapter.QueryTest do
  use MangarooWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "chapter" do
    test "returns the Chapter record of the given ID", %{conn: conn} do
      manga = manga_fixture()
      chapter = chapter_fixture(manga)

      query = """
        query GetChapter($id: ID!) {
          chapter(id: $id) {
            id
            name
            mangaId
            manga {
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
        }
      """

      variables = %{id: chapter.id}

      response =
        conn
        |> post(
          "/api",
          query_skeleton(query, "GetChapter", variables)
        )
        |> json_response(200)

      assert response["data"]["chapter"]["id"] == "#{chapter.id}"
      assert response["data"]["chapter"]["mangaId"] == "#{manga.id}"
      assert response["data"]["chapter"]["name"] == "Factory Chapter Name"
      assert response["data"]["chapter"]["manga"]["id"]
      assert response["data"]["chapter"]["manga"]["name"] == "Factory Manga Name"
      assert response["data"]["chapter"]["manga"]["author"] == "Factory Manga Author"
      assert response["data"]["chapter"]["manga"]["artist"] == "Factory Manga Artist"
      assert response["data"]["chapter"]["manga"]["status"] == "ongoing"
      assert response["data"]["chapter"]["manga"]["demographic"] == "shounen"
      assert response["data"]["chapter"]["manga"]["isHentai"] == false
      assert response["data"]["chapter"]["manga"]["description"] == "Factory Manga Description"
    end
  end
end
