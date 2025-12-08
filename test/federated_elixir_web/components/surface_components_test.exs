defmodule FederatedElixirWeb.SurfaceComponentsTest do
  use ExUnit.Case
  use Surface.LiveViewTest

  alias FederatedElixir.Mastodon

  alias FederatedElixirWeb.SurfaceComponents.{
    CardImageBanner,
    CardImageSquare,
    Feed,
    PostCard,
    PostHeader,
    Post
  }

  describe "CardImageBanner" do
    test "renders an image with a title and a provider name" do
      assigns = %{
        image: "test/image.webp",
        width: 200,
        provider_name: "test.org",
        title: "Test image"
      }

      html =
        render_surface do
          ~F"""
          <CardImageBanner image={@image} width={@width} provider_name={@provider_name} title={@title} />
          """
        end

      assert html =~ "<img src=\"test/image.webp\""
      assert html =~ "width=\"200\""
      assert html =~ "Test image"
      assert html =~ "test.org"
    end
  end

  describe "CardImageSquare" do
    test "renders a 144x144 image with a title and a provider name" do
      assigns = %{
        image: "test/image.webp",
        provider_name: "test.org",
        title: "Test image"
      }

      html =
        render_surface do
          ~F"""
          <CardImageSquare image={@image} provider_name={@provider_name} title={@title} />
          """
        end

      assert html =~ "<img src=\"test/image.webp\""
      assert html =~ "width=\"144\""
      assert html =~ "Test image"
      assert html =~ "test.org"
    end

    test "renders a 144x144 placeholder icon with a title and a provider name" do
      assigns = %{
        provider_name: "test.org",
        title: "Test image"
      }

      html =
        render_surface do
          ~F"""
          <CardImageSquare provider_name={@provider_name} title={@title} />
          """
        end

      assert html =~ "<span class=\"hero-arrow-top-right-on-square"
      assert html =~ "Test image"
      assert html =~ "test.org"
    end
  end

  describe "PostHeader" do
    test "renders a header containing a link to the author profile and a creation date with year" do
      assigns = %{
        account: %{
          "url" => "https://user.profile.com",
          "avatar_static" => "https://avatar.profile.com",
          "display_name" => "John Doe",
          "acct" => "john@profile.com"
        },
        creation_date_time: "2024-12-08T11:57:03Z"
      }

      html =
        render_surface do
          ~F"""
          <PostHeader account={@account} creation_date_time={@creation_date_time} />
          """
        end

      assert html =~ "href=\"https://user.profile.com\""
      assert html =~ "src=\"https://avatar.profile.com\""
      assert html =~ "John Doe"
      assert html =~ "<p>08/12/2024</p>"
    end

    test "renders a post creation date without year" do
      %{day: last_week_day, month: last_week_month} =
        last_week = DateTime.utc_now() |> DateTime.shift(week: -1)

      last_week_day = last_week_day |> Integer.to_string() |> String.pad_leading(2, "0")

      assigns = %{
        account: %{
          "url" => "https://user.profile.com",
          "avatar_static" => "https://avatar.profile.com",
          "display_name" => "John Doe",
          "acct" => "john@profile.com"
        },
        creation_date_time: last_week |> DateTime.to_iso8601()
      }

      html =
        render_surface do
          ~F"""
          <PostHeader account={@account} creation_date_time={@creation_date_time} />
          """
        end

      assert html =~ "<p>#{last_week_day}/#{last_week_month}</p>"
    end

    test "renders the number of days since the post creation" do
      assigns = %{
        account: %{
          "url" => "https://user.profile.com",
          "avatar_static" => "https://avatar.profile.com",
          "display_name" => "John Doe",
          "acct" => "john@profile.com"
        },
        creation_date_time: DateTime.utc_now() |> DateTime.shift(day: -1) |> DateTime.to_iso8601()
      }

      html =
        render_surface do
          ~F"""
          <PostHeader account={@account} creation_date_time={@creation_date_time} />
          """
        end

      assert html =~ "1 d"
    end

    test "renders the number of hours since the post creation" do
      assigns = %{
        account: %{
          "url" => "https://user.profile.com",
          "avatar_static" => "https://avatar.profile.com",
          "display_name" => "John Doe",
          "acct" => "john@profile.com"
        },
        creation_date_time:
          DateTime.utc_now() |> DateTime.shift(hour: -1) |> DateTime.to_iso8601()
      }

      html =
        render_surface do
          ~F"""
          <PostHeader account={@account} creation_date_time={@creation_date_time} />
          """
        end

      assert html =~ "1 h"
    end

    test "renders the number of minutes since the post creation" do
      assigns = %{
        account: %{
          "url" => "https://user.profile.com",
          "avatar_static" => "https://avatar.profile.com",
          "display_name" => "John Doe",
          "acct" => "john@profile.com"
        },
        creation_date_time:
          DateTime.utc_now() |> DateTime.shift(minute: -1) |> DateTime.to_iso8601()
      }

      html =
        render_surface do
          ~F"""
          <PostHeader account={@account} creation_date_time={@creation_date_time} />
          """
        end

      assert html =~ "1 min"
    end

    test "renders the number of seconds since the post creation" do
      assigns = %{
        account: %{
          "url" => "https://user.profile.com",
          "avatar_static" => "https://avatar.profile.com",
          "display_name" => "John Doe",
          "acct" => "john@profile.com"
        },
        creation_date_time:
          DateTime.utc_now() |> DateTime.shift(second: -1) |> DateTime.to_iso8601()
      }

      html =
        render_surface do
          ~F"""
          <PostHeader account={@account} creation_date_time={@creation_date_time} />
          """
        end

      assert html =~ "1 s"
    end
  end

  describe "PostCard" do
    test "renders a link with a banner image" do
      assigns = %{
        card: %{
          "url" => "https://test.org/tests",
          "width" => 400,
          "height" => 100,
          "image" => "test/image.webp",
          "provider_name" => "test.org",
          "title" => "Banner image"
        }
      }

      html =
        render_surface do
          ~F"""
          <PostCard card={@card} />
          """
        end

      assert html =~ "href=\"https://test.org/tests\""
      assert html =~ "<img src=\"test/image.webp\""
      assert html =~ "width=\"400\""
      assert html =~ "Banner image"
      assert html =~ "test.org"
    end

    test "renders a link with a square image" do
      assigns = %{
        card: %{
          "url" => "https://test.org/tests",
          "width" => 0,
          "image" => "test/image.webp",
          "provider_name" => "test.org",
          "title" => "Square image"
        }
      }

      html =
        render_surface do
          ~F"""
          <PostCard card={@card} />
          """
        end

      assert html =~ "href=\"https://test.org/tests\""
      assert html =~ "<img src=\"test/image.webp\""
      assert html =~ "width=\"144\""
      assert html =~ "Square image"
      assert html =~ "test.org"
    end
  end

  describe "Post" do
    test "render a post with a header, its content, an image and its url" do
      assigns = %{
        id: "post-test",
        post: %Mastodon.Post{
          id: "not-last-post",
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
        },
        last_post_id: "last-post"
      }

      html =
        render_surface do
          ~F"""
          <Post id={@id} post={@post} last_post_id={@last_post_id} />
          """
        end

      assert html =~ "John Doe"
      assert html =~ "08/12/2024"
      assert html =~ "id=\"post-test\""
      assert html =~ "Banner image"
      assert html =~ "<p>Hello World !</p>"
      assert html =~ "<img src=\"https://image.url\">"
      assert html =~ "<a href=\"https://post.url\""
      assert html =~ "<hr>"
    end

    test "renders a last post a video as attachment" do
      assigns = %{
        id: "post-test",
        post: %Mastodon.Post{
          id: "last-post",
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
            "title" => "Square image"
          },
          media_attachments: [
            %{"type" => "video", "url" => "https://video.url"}
          ],
          url: "https://post.url"
        },
        last_post_id: "last-post"
      }

      html =
        render_surface do
          ~F"""
          <Post id={@id} post={@post} last_post_id={@last_post_id} />
          """
        end

      assert html =~ "John Doe"
      assert html =~ "08/12/2024"
      assert html =~ "id=\"post-test\""
      assert html =~ "Square image"
      assert html =~ "<p>Hello World !</p>"
      assert html =~ "<video src=\"https://video.url\""
      assert html =~ "<a href=\"https://post.url\""
      refute html =~ "<hr>"
    end
  end

  describe "Feed" do
    test "renders a feed populated with posts" do
      assigns = %{
        is_error: false,
        last_post_id: "last-post",
        posts: [
          {"posts-last-post",
           %Mastodon.Post{
             id: "last-post",
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
           }}
        ]
      }

      html =
        render_surface do
          ~F"""
          <Feed posts={@posts} is_error={@is_error} last_post_id={@last_post_id} />
          """
        end

      assert html =~ "<p>Hello World !</p>"
    end
  end
end
