defmodule FederatedElixirWeb.SurfaceComponents.Feed do
  @moduledoc """
  Surface component used to render application feed conataining all the Fediverse post with the #elixir tag.
  """
  use Surface.Component

  alias FederatedElixirWeb.SurfaceComponents.Post

  @impl true
  prop(posts, :struct)
  prop(is_error, :boolean, default: false)
  prop(last_post_id, :string, required: true)

  def render(assigns) do
    ~F"""
    <div class="border-2 rounded-xl" phx-update="stream">
      <p id="empty-case" class="only:block hidden text-center my-8">Loading ...</p>
      <div
        :if={@is_error}
        class="w-fit my-8 mx-auto p-4 rounded-xl bg-error text-center text-error-content"
      >
        <p class="font-bold">An error occured !</p>
        <p>Please refresh the feed or try later.</p>
      </div>
      {#for {dom_id, post} <- @posts}
        <Post id={dom_id} post={post} last_post_id={@last_post_id} />
      {/for}
    </div>
    """
  end
end
