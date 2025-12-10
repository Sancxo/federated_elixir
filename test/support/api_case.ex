defmodule FederatedElixirWeb.ApiCase do
  @moduledoc """
  This module defines the setup for tests requiring
  access to the application's api layer.

  You may define functions here to be used as helpers in
  your tests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      import FederatedElixirWeb.ApiCase

      setup context do
        bypass = Bypass.open()

        mastodon_api_env =
          Application.get_env(:federated_elixir, FederatedElixir.Mastodon)

        updated_env = [
          {:mastodon_api_url, "http://localhost:#{bypass.port}/api/v1/timelines/tag/elixir"}
          | mastodon_api_env
        ]

        Application.put_env(:federated_elixir, FederatedElixir.Mastodon, updated_env)

        {:ok, bypass: bypass}
      end
    end
  end
end
