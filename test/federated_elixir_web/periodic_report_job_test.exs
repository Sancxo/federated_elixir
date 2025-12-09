defmodule FederatedElixirWeb.PeriodicReportJobTest do
  use FederatedElixir.DataCase
  use MastodonApiMockedData
  import FederatedElixir.AccountsFixtures
  alias FederatedElixirWeb.PeriodicReportJob

  setup do
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

  test "handle_info is called when :send_weekly_review message is received", %{bypass: bypass} do
    _subscriber = user_fixture(subscribe_to_newsletter: true)

    %{newest_post_id: newest_post_id} = :sys.get_state(PeriodicReportJob)
    assert newest_post_id == nil

    # First weekly review with an initial state set to `nil`
    Bypass.expect_once(
      bypass,
      "GET",
      "/api/v1/timelines/tag/elixir",
      fn conn ->
        assert conn.query_params == %{"limit" => "40"}
        Req.Test.json(conn, @mock_first_post)
      end
    )

    send(PeriodicReportJob, :send_weekly_review)

    # we need to get the GenServer state once before in order to be sure that the state was effectively updated
    :sys.get_state(PeriodicReportJob)

    %{newest_post_id: newest_post_id} = :sys.get_state(PeriodicReportJob)

    [first_mocked_post | _] = @mock_first_post
    assert newest_post_id == first_mocked_post["id"]

    # Second weekly review with an initial state set to the previous post id
    Bypass.expect_once(
      bypass,
      "GET",
      "/api/v1/timelines/tag/elixir",
      fn conn ->
        assert conn.query_params == %{"limit" => "40", "since_id" => newest_post_id}
        Req.Test.json(conn, @mock_second_post)
      end
    )

    send(PeriodicReportJob, :send_weekly_review)

    # we need to get the GenServer state once before in order to be sure that the state was effectively updated
    :sys.get_state(PeriodicReportJob)

    %{newest_post_id: newest_post_id} = :sys.get_state(PeriodicReportJob)

    [second_mocked_post | _] = @mock_second_post
    assert newest_post_id == second_mocked_post["id"]
  end
end
