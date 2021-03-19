defmodule Mangaroo.Middleware.ValidateCommand do
  @moduledoc """
  To give command validations some form of structure, this middleware enforces
  command modules to implement Ecto.Schema and Ecto.Changeset for doing validations
  before we pass it into the EventStore.

  Since the EventStore and the actual database that we're doing queries from are
  different, uniqueness validations or any validations that need to collide with a
  record first have to be done manually because the EventStore doesn't discriminate
  commands by default.
  """

  @behaviour Commanded.Middleware

  alias Commanded.Middleware.Pipeline

  def before_dispatch(%Pipeline{command: command} = pipeline) do
    # Yes, it looks confusing, but it actually just looks like this after the fact:
    # CreateUser.changeset(%CreateUser{}, %{attrs: "from the command struct"})
    changeset =
      command
      |> Map.get(:__struct__)
      |> struct()
      |> command.__struct__.changeset(Map.from_struct(command))

    if changeset.valid? do
      Map.put(pipeline, :command, Ecto.Changeset.apply_changes(changeset))
    else
      pipeline
      |> Pipeline.respond({:error, changeset})
      |> Pipeline.halt()
    end
  end

  def after_dispatch(pipeline), do: pipeline
  def after_failure(pipeline), do: pipeline
end
