defmodule Mangaroo.Behaviour.MangarooCommand do
  @moduledoc """
  All of our Commands should implement the changeset method
  because the ValidateCommand middleware is depending on it.
  """

  @callback changeset(Ecto.Schema.t(), Map.t()) :: Ecto.Changeset.t()
end
