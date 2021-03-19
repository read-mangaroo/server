defmodule Mangaroo.EventStore do
  @moduledoc false

  use EventStore, otp_app: :mangaroo

  def init(config) do
    {:ok, config}
  end
end
