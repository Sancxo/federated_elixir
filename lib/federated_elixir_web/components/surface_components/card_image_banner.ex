defmodule FederatedElixirWeb.SurfaceComponents.CardImageBanner do
  @moduledoc """
  Surface component for large post card.
  """
  use Surface.Component

  @impl true
  prop(image, :string, default: "")
  prop(width, :integer, required: true)
  prop(provider_name, :string, default: "")
  prop(title, :string, default: "")

  def render(assigns) do
    ~F"""
    <div class="w-full flex flex-col gap-4 justify-center">
      <img src={@image} height="144" width={@width} class="w-full">
      <div class="p-4">
        <h4 class="text-base-content/70">{@provider_name}</h4>
        <p class="group-hover:underline">{@title}</p>
      </div>
    </div>
    """
  end
end
