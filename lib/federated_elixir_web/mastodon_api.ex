defmodule FederatedElixirWeb.MastodonApi do
  @moduledoc """
  An API module providing functions to communicate with Mastodon.

  Available functions:
  - `fetch_latest_posts/0`: renders the 20 latest posts with `elixir` hashtag.
  - `fetch_previous_posts/1`: load the 20 posts with `elixir` hashtag published before the ones from the above function.
  """
  alias FederatedElixir.Mastodon.Post

  @elixir_hashtag_uri "https://mastodon.social/api/v1/timelines/tag/elixir"

  @doc """
  Asynchronous function to get the list of the 20 latest posts on Mastodon with the `#elixir` hashtag.
  Data returned by the request is broadcasted on `"mastodon_api_topic"` when available.
  """
  @spec fetch_latest_posts() :: :ok
  def fetch_latest_posts() do
    resp =
      Task.async(fn ->
        Req.get(@elixir_hashtag_uri)
      end)
      |> Task.await()
      |> handle_data()

    broadcast_api(resp, :latest_posts_fetched)
  end

  @doc """
  Asynchronous function to get the 2O posts older than the post id given as parameter.
  Data returned by the request is broadcasted on `"mastodon_api_topic"` when available.
  """
  @spec fetch_previous_posts(String.t()) :: :ok
  def fetch_previous_posts(from_id) do
    resp =
      Task.async(fn ->
        Req.get("#{@elixir_hashtag_uri}?max_id=#{from_id}")
      end)
      |> Task.await()
      |> handle_data()

    broadcast_api(resp, :previous_posts_fetched)
  end

  # PubSub functions
  @doc """
  Subscribe function used by modules who want to receive messages and data sent by this GenServer
  """
  @spec subscribe_api() :: :ok | {:error, term()}
  def subscribe_api, do: Phoenix.PubSub.subscribe(FederatedElixir.PubSub, "mastodon_api_topic")

  # Broadcast function use by this module to send message and data
  @spec broadcast_api(term(), atom()) :: :ok | {:error, term()}
  defp broadcast_api(message, event) do
    Phoenix.PubSub.broadcast(FederatedElixir.PubSub, "mastodon_api_topic", {event, message})
  end

  # Private function used to parse data received from Mastodon and to return a three-entry tuple readable by the HomeLive module
  @spec handle_data({:ok, Req.Response.t() | {:error, Exception.t()}}) ::
          {list(), String.t() | nil, boolean()}
  defp handle_data({:ok, %Req.Response{body: posts}}) do
    posts =
      Enum.map(posts, fn post ->
        Post.new(post)
      end)

    last_post = List.last(posts)

    {posts, last_post.id, false}
  end

  defp handle_data({:error, _}) do
    {[], nil, true}
  end
end
