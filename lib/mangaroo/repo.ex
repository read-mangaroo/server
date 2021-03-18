defmodule Mangaroo.Repo do
  use Ecto.Repo,
    otp_app: :mangaroo,
    adapter: Ecto.Adapters.Postgres
end
