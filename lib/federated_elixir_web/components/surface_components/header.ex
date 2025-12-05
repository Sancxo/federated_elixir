defmodule FederatedElixirWeb.SurfaceComponents.Header do
  @moduledoc """
  Surface component inspired by the Phoenix `header/1` core component to render a basic header.
  """
  use Surface.Component

  @impl true
  slot(default, required: true)
  slot(subtitle)
  slot(actions)

  def render(assigns) do
    ~F"""
    <header class={[slot_assigned?(:actions) && "flex items-center justify-between gap-6", "pb-4"]}>
      <div class="m-auto text-center">
        <h1 class="text-lg font-semibold leading-8"><#slot /></h1>
        <p :if={slot_assigned?(:subtitle)} class="text-sm text-base-content/70">
          <#slot {@subtitle} />
        </p>
      </div>
      <div class="flex-none"><#slot {@actions} /></div>
    </header>
    """
  end
end
