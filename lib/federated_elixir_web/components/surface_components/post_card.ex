defmodule FederatedElixirWeb.SurfaceComponents.PostCard do
  @moduledoc """
  PostCard is a component used to render the card informations returned by the Mastodon API.
  The card entry is used by the Mastodon API to display a link informations such as an illustration,
  a hostname and a page title.
  """
  use Surface.Component
  alias FederatedElixirWeb.SurfaceComponents.CardImageSquare
  alias FederatedElixirWeb.SurfaceComponents.CardImageBanner

  @impl true
  prop(card, :map, required: true)

  def render(assigns) do
    ~F"""
    <a target="_blank" href={@card["url"]} class="group border">
      {#if @card["width"] == 0 || (@card["height"] != 0 && @card["width"] / @card["height"] == 1)}
        <CardImageSquare
          image={@card["image"]}
          provider_name={@card["provider_name"]}
          title={@card["title"]}
        />
      {#else}
        <CardImageBanner
          image={@card["image"]}
          width={@card["width"]}
          provider_name={@card["provider_name"]}
          title={@card["title"]}
        />
      {/if}
    </a>
    """
  end
end
