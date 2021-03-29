defmodule MangarooWeb.AbsintheHelpers do
  @moduledoc """
  Helper module for testing GraphQL queries/mutations
  """

  def query_skeleton(query, query_name, variables \\ %{}) do
    %{
      "operationName" => "#{query_name}",
      "query" => "#{query}",
      "variables" => variables
    }
  end
end
