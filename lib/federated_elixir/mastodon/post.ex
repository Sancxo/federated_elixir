defmodule FederatedElixir.Mastodon.Post do
  @moduledoc """
  Embedded schema to handle Mastodon API posts sent back for the GET request.
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :string, autogenerate: false}
  embedded_schema do
    field :account, :map
    field :created_at, :string
    field :content, :string
    field :card, :map
    field :media_attachments, {:array, :string}
    field :url, :string
  end

  def new(data) do
    data
    |> changeset()
    |> apply_changes()
  end

  def changeset(attrs \\ %{}) do
    %__MODULE__{}
    |> cast(attrs, [
      :id,
      :account,
      :created_at,
      :content,
      :card,
      :media_attachments,
      :url
    ])
    |> validate_required([:id, :account, :created_at, :content, :url])
  end
end
