defmodule FederatedElixirWeb.SurfaceComponents.PostHeader do
  @moduledoc """
  Surface component to display the post header. The post header contains the author pseudo and avatar,
  his Fediverse actor address and his profile url.
  """
  use Surface.Component

  @impl true
  prop(account, :map, required: true)

  def render(assigns) do
    ~F"""
    <a target="_blank" href={@account["url"]} class="group flex gap-4">
      <img src={@account["avatar_static"]} height="46" width="46" class="rounded">
      <div>
        <h3 class="font-bold group-hover:underline">{@account["display_name"]}</h3>
        <p class="text-base-content/70">@{@account["acct"]}</p>
      </div>
    </a>
    """
  end
end
