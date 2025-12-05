defmodule FederatedElixirWeb.HomeLive do
  @moduledoc """
  Main live view used to display Mastodon feed of elixir-related posts.
  """
  use FederatedElixirWeb, :surface_live_view

  alias FederatedElixirWeb.MastodonApi
  alias FederatedElixirWeb.SurfaceComponents.Feed
  alias FederatedElixirWeb.SurfaceComponents.Header

  @impl true
  def render(assigns) do
    ~F"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <Header>
        Federated Elixir
        <:subtitle>Get the freshest Elixir news from the Fediverse.</:subtitle>
        <:actions><.button variant="primary" phx-click="reset-feed">Reset feed <.icon name="hero-arrow-path" /></.button></:actions>
      </Header>

      <Feed posts={@streams.posts} is_error={@is_error} last_post_id={@last_post_id} />

      <div class="flex justify-center">
        <.button variant="primary" phx-click="load-more-posts">Load more <.icon name="hero-plus" /></.button>
      </div>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      MastodonApi.subscribe_api()
    end

    MastodonApi.fetch_latest_posts()

    {:ok, socket |> stream(:posts, []) |> assign(is_error: false, last_post_id: "")}
  end

  @impl true
  def handle_event("reset-feed", _params, socket) do
    MastodonApi.fetch_latest_posts()

    {:noreply, socket}
  end

  @impl true
  def handle_event("load-more-posts", _params, socket) do
    MastodonApi.fetch_previous_posts(socket.assigns.last_post_id)

    {:noreply, socket}
  end

  @impl true
  def handle_info({:latest_posts_fetched, data}, socket) do
    {data, is_error} = parse_result(data)

    posts =
      Enum.map(data.body, fn post ->
        Map.new(post, fn {key, value} ->
          {String.to_atom(key), value}
        end)
      end)

    [last_post | _] = Enum.reverse(posts)

    {:noreply,
     socket
     |> stream(:posts, posts |> IO.inspect(label: "posts"), reset: true)
     |> assign(is_error: is_error, last_post_id: last_post.id)}
  end

  @impl true
  def handle_info({:previous_posts_fetched, data}, socket) do
    {data, is_error} = parse_result(data)

    posts =
      Enum.map(data.body, fn post ->
        Map.new(post, fn {key, value} ->
          {String.to_atom(key), value}
        end)
      end)

    [last_post | _] = Enum.reverse(posts)

    {:noreply,
     socket
     |> stream(:posts, posts, reset: false)
     |> assign(is_error: is_error, last_post_id: last_post.id)}
  end

  @spec parse_result({:ok, term() | {:error, term}}) :: {term(), boolean()}
  defp parse_result(fetch) do
    case fetch do
      {:ok, data} -> {data, false}
      {:error, _} -> {[], true}
    end
  end
end
