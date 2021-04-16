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

      variables = %{
        "input" => %{
          "name" => "Test Chapter Name",
          "mangaId" => manga.id
        }
      }

      response =
        conn
        |> post(
          "/api",
          query_skeleton(mutation, "CreateChapter", variables)
        )
        |> json_response(200)

      assert response["data"]["createChapter"]["id"]
      assert response["data"]["createChapter"]["mangaId"] == "#{manga.id}"
      assert response["data"]["createChapter"]["name"] == "Test Chapter Name"
    end
  end
end
