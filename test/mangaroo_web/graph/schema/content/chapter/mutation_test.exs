defmodule MangarooWeb.Graph.Schema.Content.Chapter.MutationTest do
  use MangarooWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "createChapter" do
    test "with valid data returns Chapter", %{conn: conn} do
      mutation = """
        mutation CreateChapter($input: CreateChapterInput!) {
          createChapter(input: $input) {
            id
            name
            mangaId
          }
        }
      """

      manga = manga_fixture()

      chapter_archive = %Plug.Upload{
        content_type: "application/zip",
        filename: "test chapter.zip",
        path: Path.expand("../../../../../fixtures/test chapter.zip", __DIR__)
      }

      variables = %{
        "input" => %{
          "name" => "Test Chapter Name",
          "mangaId" => manga.id,
          "chapterArchive" => "chapterArchive"
        }
      }

      response =
        conn
        |> post(
          "/api",
          query: mutation,
          variables: variables,
          chapterArchive: chapter_archive
        )
        |> json_response(200)

      assert response["data"]["createChapter"]["id"]
      assert response["data"]["createChapter"]["mangaId"] == "#{manga.id}"
      assert response["data"]["createChapter"]["name"] == "Test Chapter Name"
    end
  end
end
