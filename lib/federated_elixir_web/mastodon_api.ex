defmodule FederatedElixirWeb.MastodonApi do
  @moduledoc """
  A GenServer providing functions to communicate with Mastodon through their API.

  Available functions:
  - `fetch_latest_posts`: renders the 20 latest posts
  - `fetch_previous_posts`: load the 20 posts published before

  This server is also responsible to send each monday at 00:00 (UTC) a mail containing the
  40 latest posts published since the previous review to all the users who subscribed to it
  """
  use GenServer
  require Logger

  alias FederatedElixir.Accounts

  @elixir_hashtag_uri "https://mastodon.social/api/v1/timelines/tag/elixir"

  @doc false
  def start_link(_initial_state) do
    GenServer.start_link(__MODULE__, %{newest_post_id: nil}, name: __MODULE__)
  end

  @doc """
  Asynchronous function to get the list of the 20 latest posts on Mastodon with the `#elixir` hashtag.
  Data returned by the request is broadcasted on `"mastodon_api_topic"` when available.
  """
  @spec fetch_latest_posts() :: :ok
  def fetch_latest_posts(),
    do: GenServer.cast(__MODULE__, :fetch_latest_posts)

  @doc """
  Asynchronous function to get the 2O posts older than the post id given as parameter.
  Data returned by the request is broadcasted on `"mastodon_api_topic"` when available.
  """
  @spec fetch_previous_posts(String.t()) :: :ok
  def fetch_previous_posts(from_id),
    do: GenServer.cast(__MODULE__, {:fetch_previous_posts, from_id})

  # PubSub functions
  @doc """
  Subscribe function used by modules who want to receive messages and data sent by this GenServer
  """
  @spec subscribe_api() :: :ok | {:error, term()}
  def subscribe_api, do: Phoenix.PubSub.subscribe(FederatedElixir.PubSub, "mastodon_api_topic")

  # Broadcast function use by this module to send message and data
  @spec broadcast_api(term(), atom()) :: {:ok, term()}
  defp broadcast_api(message, event) do
    Phoenix.PubSub.broadcast(FederatedElixir.PubSub, "mastodon_api_topic", {event, message})

    {:ok, message}
  end

  @impl true
  @doc false
  def init(state \\ %{}) do
    Process.send_after(self(), :send_weekly_review, get_next_delivery_date_in_ms())

    {:ok, state}
  end

  @impl true
  @doc false
  def handle_cast(:fetch_latest_posts, state) do
    resp = Req.get(@elixir_hashtag_uri)

    broadcast_api(resp, :latest_posts_fetched)

    {:noreply, state}
  end

  @impl true
  def handle_cast({:fetch_previous_posts, from_id}, state) do
    resp = Req.get("#{@elixir_hashtag_uri}?max_id=#{from_id}")

    broadcast_api(resp, :previous_posts_fetched)

    {:noreply, state}
  end

  @impl true
  @doc false
  def handle_info(:send_weekly_review, state) do
    send_weekly_review(state)
    {:noreply, state}
  end

  @impl true
  def handle_info({:update_newest_post, newest_post_id}, state) do
    {:noreply, Map.put(state, :newest_post_id, newest_post_id)}
  end

  # Private function called periodically (once a week) by handle_info in order to get the
  # 40 latest posts on Mastodon since the last post fetched and containing the `#elixir` hashtag,
  # then to send it to the users who subscribed to it
  @spec send_weekly_review(map()) :: reference()
  defp send_weekly_review(state) do
    fetch_posts =
      Task.async(fn ->
        last_post_id_param =
          case state.newest_post_id do
            nil -> ""
            id -> "&since_id=" <> id
          end

        Req.get(@elixir_hashtag_uri <> "?limit=40" <> last_post_id_param)
      end)

    with {:ok, %Req.Response{body: posts}} <- Task.await(fetch_posts) do
      Accounts.list_newsletter_recipients()
      |> Task.async_stream(
        fn recipient ->
          Logger.info("Hi #{recipient.email} ! Here is your weekly report : #{inspect(posts)}")
        end,
        ordered: false
      )
      |> Stream.run()

      [%{"id" => newest_post_id} | _] = posts

      send(self(), {:update_newest_post, newest_post_id})
    end

    Process.send_after(self(), :send_weekly_review, get_next_delivery_date_in_ms())
  end

  # Private function used to calculat when is next monday at 00:00 in milliseconds
  @spec get_next_delivery_date_in_ms() :: integer()
  defp get_next_delivery_date_in_ms() do
    # The weekly review is sent each Monday at midnight,
    # so we need to calculate the difference in millisecond between now and next monday
    {:ok, next_monday_datetime} =
      Date.utc_today()
      |> Date.beginning_of_week()
      |> Date.add(7)
      |> DateTime.new(~T[00:00:00])

    DateTime.diff(next_monday_datetime, DateTime.utc_now(), :millisecond)
  end
end
