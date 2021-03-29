defmodule MangarooWeb.Graph.Context do
  @moduledoc """
  GraphQL context for Mangaroo.
  """

  @behaviour Plug

  def init(opts), do: opts

  def call(conn, _), do: conn
end
