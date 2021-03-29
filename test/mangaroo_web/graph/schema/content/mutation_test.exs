defmodule MangarooWeb.Graph.Schema.Content.MutationTest do
  use MangarooWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @create_manga_operation_name "CreateManga"
  @create_manga_mutation """
  mutation CreateManga($input: CreateMangaInput!) {
    createManga(input: $input) {
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

  describe "createManga" do
    test "with valid data returns Manga", %{conn: conn} do
      variables = %{
        "input" => %{
          "name" => "Test Manga Name",
          "author" => "Test Manga Author",
          "artist" => "Test Manga Artist",
          "status" => "ongoing",
          "demographic" => "shounen",
          "isHentai" => false,
          "description" => "Test Manga Description"
        }
      }

      response =
        conn
        |> post(
          "/api",
          query_skeleton(@create_manga_mutation, @create_manga_operation_name, variables)
        )
        |> json_response(200)

      assert response["data"]["createManga"]["artist"] == "Test Manga Artist"
      assert response["data"]["createManga"]["author"] == "Test Manga Author"
      assert response["data"]["createManga"]["demographic"] == "shounen"
      assert response["data"]["createManga"]["description"] == "Test Manga Description"
      assert response["data"]["createManga"]["id"]
      assert response["data"]["createManga"]["isHentai"] == false
      assert response["data"]["createManga"]["name"] == "Test Manga Name"
      assert response["data"]["createManga"]["status"] == "ongoing"
    end

    test "with invalid status returns error", %{conn: conn} do
      variables = %{
        "input" => %{
          "name" => "Test Manga Name",
          "author" => "Test Manga Author",
          "artist" => "Test Manga Artist",
          "status" => "invalid",
          "demographic" => "shounen",
          "isHentai" => false,
          "description" => "Test Manga Description"
        }
      }

      response =
        conn
        |> post(
          "/api",
          query_skeleton(@create_manga_mutation, @create_manga_operation_name, variables)
        )
        |> json_response(200)

      error = Enum.at(response["errors"], 0)

      assert response["data"]["createManga"] == nil
      assert error["message"] == "status is invalid"
    end
  end
end
