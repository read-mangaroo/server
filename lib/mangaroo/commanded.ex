defmodule Mangaroo.Commanded do
  @moduledoc false

  use Commanded.Application, otp_app: :mangaroo

  router(Mangaroo.CommandedRouter)
end
