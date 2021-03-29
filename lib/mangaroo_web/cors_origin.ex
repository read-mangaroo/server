defmodule MangarooWeb.CorsOrigin do
  @moduledoc false
  def origin do
    Application.get_env(:mangaroo, :cors_origin)
  end
end
