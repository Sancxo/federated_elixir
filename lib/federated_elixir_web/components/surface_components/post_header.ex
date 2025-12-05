defmodule FederatedElixirWeb.SurfaceComponents.PostHeader do
  @moduledoc """
  Surface component to display the post header. The post header contains the author pseudo and avatar,
  his Fediverse actor address and his profile url.
  """
  use Surface.Component

  @impl true
  prop(account, :map, required: true)
  prop(creation_date_time, :string, required: true)

  def render(assigns) do
    ~F"""
    <div class="flex justify-between">
      <a target="_blank" href={@account["url"]} class="group flex gap-4">
        <img src={@account["avatar_static"]} height="46" width="46" class="rounded">
        <div>
          <h3 class="font-bold group-hover:underline">{@account["display_name"]}</h3>
          <p class="text-base-content/70">@{@account["acct"]}</p>
        </div>
      </a>
      <p>{get_publication_time(@creation_date_time)}</p>
    </div>
    """
  end

  def get_publication_time(created_at) do
    {:ok, creation_datetime, _offset} = DateTime.from_iso8601(created_at)

    DateTime.diff(DateTime.utc_now(), creation_datetime)
    |> case do
      seconds when seconds < 60 ->
        "#{seconds} s"

      minutes when minutes < 60 * 60 ->
        "#{div(minutes, 60)} min"

      hours when hours < 24 * 60 * 60 ->
        "#{div(hours, 60 * 60)} h"

      days when days < 7 * 24 * 60 * 60 ->
        "#{div(days, 24 * 60 * 60)} d"

      _ ->
        %{day: day, month: month, year: creation_year} = DateTime.to_date(creation_datetime)
        %{year: current_year} = Date.utc_today()

        (creation_year == current_year &&
           "#{day}/#{month}") || "#{day}/#{month}/#{creation_year}"
    end
  end
end
