defmodule Mangaroo.CommandedRouter do
  @moduledoc """
  Main router for use with Commanded.
  """

  use Commanded.Commands.CompositeRouter

  router(Mangaroo.Concept.Content.Router)
end
