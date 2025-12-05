defmodule FederatedElixirWeb.SurfaceComponents.Post do
  @moduledoc """
  Surface component displaying a Post inside the Feed.
  As posts are stored in a stream inside the HomeLiveView, they need
  an id to be displayed and posts are represented as a Struct.
  """
  use Surface.Component

  use Phoenix.VerifiedRoutes,
    endpoint: FederatedElixirWeb.Endpoint,
    router: FederatedElixirWeb.Router

  alias FederatedElixirWeb.SurfaceComponents.PostHeader
  alias FederatedElixirWeb.SurfaceComponents.PostCard

  @impl true
  prop(id, :string)
  prop(post, :struct)
  prop(last_post_id, :string, required: true)

  def render(assigns) do
    ~F"""
    <article id={@id} class="flex flex-col gap-4 p-4">
      <PostHeader account={@post.account} />

      <div class="[&_a]:hover:underline [&_a.mention]:text-base-content/70 [&_a:not(.mention)]:text-primary">
        {raw(@post.content)}
      </div>

      <PostCard :if={@post.card} card={@post.card} />

      {#if @post.media_attachments}
        {#for attachment <- @post.media_attachments}
          <div>
            {#if attachment["type"] == "image"}
              <img src={attachment["url"]}>
            {#else if(attachment["type"] == "video")}
              <video src={attachment["url"]} controls="true" />
            {/if}
          </div>
        {/for}
      {/if}

      <div class="text-center"><a href={@post.url} class="hover:underline text-base-content/70">See original post</a></div>

      <hr :if={@post.id != @last_post_id}>
    </article>
    """
  end
end
