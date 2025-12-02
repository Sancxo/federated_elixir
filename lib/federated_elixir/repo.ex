defmodule FederatedElixir.Repo do
  use Ecto.Repo,
    otp_app: :federated_elixir,
    adapter: Ecto.Adapters.Postgres
end
