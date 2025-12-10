defmodule FederatedElixirWeb.HomeLiveTest do
  use FederatedElixirWeb.ApiCase
  use FederatedElixirWeb.ConnCase
  use MastodonApiMockedData
  import Phoenix.LiveViewTest
  alias FederatedElixir.Mastodon

  test "mount live with loading message and fetch posts", %{bypass: bypass, conn: conn} do
    Bypass.expect(bypass, "GET", "/api/v1/timelines/tag/elixir", fn conn ->
      Req.Test.json(conn, @mock_second_post)
    end)

    {:ok, view, html} = live(conn, ~p"/")

    assert html =~ "Loading ...</p>"

    [older_post | _] = @mock_second_post
    assert render(view) =~ "<article id=\"posts-#{older_post["id"]}"
  end

  test "fetch newer posts when \"reset-feed\" button is clicked", %{
    conn: conn,
    bypass: bypass
  } do
    Bypass.expect(bypass, "GET", "/api/v1/timelines/tag/elixir", fn conn ->
      Req.Test.json(conn, @mock_first_post)
    end)

    {:ok, view, _html} = live(conn, ~p"/")

    [newer_post | _] = @mock_first_post

    assert view
           |> element("button", "Reset feed")
           |> render_click() =~
             "<article id=\"posts-#{newer_post["id"]}"
  end

  test "fetch older when \"load-more-posts\" button is clicked", %{
    conn: conn,
    bypass: bypass
  } do
    Bypass.expect(bypass, "GET", "/api/v1/timelines/tag/elixir", fn conn ->
      Req.Test.json(conn, @mock_third_post)
    end)

    {:ok, view, _html} = live(conn, ~p"/")

    [olderer_post | _] = @mock_third_post

    assert view
           |> element("button", "Load more")
           |> render_click() =~
             "<article id=\"posts-#{olderer_post["id"]}"
  end

  test "handle_info is called when :latest_posts_fetched message is received", %{
    conn: conn,
    bypass: bypass
  } do
    Bypass.expect(bypass, fn conn ->
      Req.Test.json(conn, @mock_second_post)
    end)

    {:ok, view, _html} = live(conn, ~p"/")

    send(
      view.pid,
      {:latest_posts_fetched,
       {[
          %Mastodon.Post{
            id: "newest-post",
            account: %{
              "url" => "https://user.profile.com",
              "avatar_static" => "https://avatar.profile.com",
              "display_name" => "John Doe",
              "acct" => "john@profile.com"
            },
            created_at: "2024-12-08T11:57:03Z",
            content: "<p>Hello World !</p>",
            card: %{
              "url" => "https://test.org/tests",
              "width" => 400,
              "height" => 100,
              "image" => "test/image.webp",
              "provider_name" => "test.org",
              "title" => "Banner image"
            },
            media_attachments: [
              %{"type" => "image", "url" => "https://image.url"}
            ],
            url: "https://post.url"
          }
        ], "newest-post", false}}
    )

    assert render(view) =~ "<p>Hello World !</p>"
  end

  test "handle_info is called when :previous_posts_fetched message is received", %{
    conn: conn,
    bypass: bypass
  } do
    Bypass.expect(bypass, fn conn ->
      Req.Test.json(conn, @mock_second_post)
    end)

    {:ok, view, _html} = live(conn, ~p"/")

    send(
      view.pid,
      {:previous_posts_fetched,
       {[
          %Mastodon.Post{
            id: "older-post",
            account: %{
              "url" => "https://user.profile.com",
              "avatar_static" => "https://avatar.profile.com",
              "display_name" => "John Doe",
              "acct" => "john@profile.com"
            },
            created_at: "2024-11-08T11:57:03Z",
            content: "<p>Hello Older World !</p>",
            card: %{
              "url" => "https://test.org/tests",
              "width" => 400,
              "height" => 100,
              "image" => "test/image.webp",
              "provider_name" => "test.org",
              "title" => "Banner image"
            },
            media_attachments: [
              %{"type" => "image", "url" => "https://image.url"}
            ],
            url: "https://post.url"
          }
        ], "older-post", false}}
    )

    assert render(view) =~ "<p>Hello Older World !</p>"
  end
end
