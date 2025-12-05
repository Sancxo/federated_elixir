defmodule FederatedElixirWeb.SurfaceComponents.CardImageSquare do
  @moduledoc """
  Surface component for small/square post card.
  """
  use Surface.Component

  alias FederatedElixirWeb.CoreComponents

  @impl true
  prop(image, :string, default: "")
  prop(provider_name, :string, default: "")
  prop(title, :string, default: "")

  def render(assigns) do
    ~F"""
    <div class="flex gap-4">
      {#if @image}
        <span class="size-36 flex items-center">
          <img src={@image} height="144" width="144">
        </span>
      {#else}
        <span class="size-36 flex justify-center items-center">
          <CoreComponents.icon name="hero-arrow-top-right-on-square" class="size-9" />
        </span>
      {/if}

      <div class="flex flex-col justify-center">
        <h4 class="text-base-content/70">{@provider_name}</h4>
        <p class="group-hover:underline">{@title}</p>
      </div>
    </div>
    """
  end
end
