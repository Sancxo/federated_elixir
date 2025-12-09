defmodule MastodonApiMockedData do
  defmacro __using__(_opts) do
    quote do
      @mock_first_post [
        %{
          "account" => %{
            "acct" => "lobsters",
            "avatar" =>
              "https://files.mastodon.social/accounts/avatars/113/635/103/853/964/473/original/0a4435eaf8d5c473.png",
            "avatar_static" =>
              "https://files.mastodon.social/accounts/avatars/113/635/103/853/964/473/original/0a4435eaf8d5c473.png",
            "bot" => true,
            "created_at" => "2024-12-11T00:00:00.000Z",
            "discoverable" => true,
            "display_name" => "Lobsters",
            "emojis" => [],
            "fields" => [
              %{
                "name" => "Lobsters",
                "value" =>
                  "<a href=\"https://lobste.rs\" target=\"_blank\" rel=\"nofollow noopener me\" translate=\"no\"><span class=\"invisible\">https://</span><span class=\"\">lobste.rs</span><span class=\"invisible\"></span></a>",
                "verified_at" => nil
              },
              %{
                "name" => "Source code",
                "value" =>
                  "<a href=\"https://github.com/lobsters/lobsters\" target=\"_blank\" rel=\"nofollow noopener me\" translate=\"no\"><span class=\"invisible\">https://</span><span class=\"\">github.com/lobsters/lobsters</span><span class=\"invisible\"></span></a> in extras/mastodon.rb, script/mastodon*",
                "verified_at" => nil
              },
              %{
                "name" => "Maintainer",
                "value" => "peter at push.cx",
                "verified_at" => nil
              }
            ],
            "followers_count" => 3491,
            "following_count" => 20,
            "group" => false,
            "header" => "https://mastodon.social/headers/original/missing.png",
            "header_static" => "https://mastodon.social/headers/original/missing.png",
            "hide_collections" => false,
            "id" => "113635103853964473",
            "indexable" => true,
            "last_status_at" => "2025-12-09",
            "locked" => false,
            "noindex" => false,
            "note" => "<p>Feed for stories that have reached the front page of lobste.rs.</p>",
            "roles" => [],
            "statuses_count" => 9549,
            "uri" => "https://mastodon.social/users/lobsters",
            "url" => "https://mastodon.social/@lobsters",
            "username" => "lobsters"
          },
          "card" => %{
            "author_name" => "",
            "author_url" => "",
            "authors" => [],
            "blurhash" => "UQLd_wx]8wDOVstRj[RPMxRjtlx]xuV@ayoz",
            "description" => "0 comments",
            "embed_url" => "",
            "height" => 144,
            "html" => "",
            "image" =>
              "https://files.mastodon.social/cache/preview_cards/images/173/673/301/original/f1b520cfa994e307.png",
            "image_description" => "",
            "language" => "en",
            "provider_name" => "Lobsters",
            "provider_url" => "",
            "published_at" => nil,
            "title" => "State of Elixir 2025 - Community Survey Results",
            "type" => "link",
            "url" => "https://lobste.rs/s/zwzwqn",
            "width" => 144
          },
          "content" =>
            "<p>State of Elixir 2025 - Community Survey Results  <a href=\"https://lobste.rs/s/zwzwqn\" target=\"_blank\" rel=\"nofollow noopener\" translate=\"no\"><span class=\"invisible\">https://</span><span class=\"\">lobste.rs/s/zwzwqn</span><span class=\"invisible\"></span></a> <a href=\"https://mastodon.social/tags/elixir\" class=\"mention hashtag\" rel=\"tag\">#<span>elixir</span></a><br /><a href=\"https://elixir-hub.com/surveys/2025\" target=\"_blank\" rel=\"nofollow noopener\" translate=\"no\"><span class=\"invisible\">https://</span><span class=\"\">elixir-hub.com/surveys/2025</span><span class=\"invisible\"></span></a></p>",
          "created_at" => "2025-12-08T11:40:10.403Z",
          "edited_at" => nil,
          "emojis" => [],
          "favourites_count" => 0,
          "id" => "115683754665029247",
          "in_reply_to_account_id" => nil,
          "in_reply_to_id" => nil,
          "language" => "en",
          "media_attachments" => [],
          "mentions" => [],
          "poll" => nil,
          "quote" => nil,
          "quote_approval" => %{
            "automatic" => ["public"],
            "current_user" => "denied",
            "manual" => []
          },
          "quotes_count" => 0,
          "reblog" => nil,
          "reblogs_count" => 0,
          "replies_count" => 0,
          "sensitive" => false,
          "spoiler_text" => "",
          "tags" => [
            %{
              "name" => "elixir",
              "url" => "https://mastodon.social/tags/elixir"
            }
          ],
          "uri" => "https://mastodon.social/users/lobsters/statuses/115683754665029247",
          "url" => "https://mastodon.social/@lobsters/115683754665029247",
          "visibility" => "public"
        }
      ]

      @mock_second_post [
        %{
          "account" => %{
            "acct" => "lawik@hachyderm.io",
            "avatar" =>
              "https://files.mastodon.social/cache/accounts/avatars/114/426/151/375/742/207/original/4175286adbae95b5.jpg",
            "avatar_static" =>
              "https://files.mastodon.social/cache/accounts/avatars/114/426/151/375/742/207/original/4175286adbae95b5.jpg",
            "bot" => false,
            "created_at" => "2025-04-30T00:00:00.000Z",
            "discoverable" => true,
            "display_name" => "Lars Wikman",
            "emojis" => [],
            "fields" => [
              %{
                "name" => "Site",
                "value" =>
                  "<a href=\"https://underjord.io\" target=\"_blank\" rel=\"nofollow noopener\" translate=\"no\"><span class=\"invisible\">https://</span><span class=\"\">underjord.io</span><span class=\"invisible\"></span></a>",
                "verified_at" => "2025-12-09T10:05:56.765+00:00"
              },
              %{
                "name" => "Links",
                "value" =>
                  "<a href=\"https://underjord.io/links.html\" rel=\"nofollow noopener\" translate=\"no\" target=\"_blank\"><span class=\"invisible\">https://</span><span class=\"\">underjord.io/links.html</span><span class=\"invisible\"></span></a>",
                "verified_at" => nil
              },
              %{
                "name" => "YouTube",
                "value" =>
                  "<a href=\"https://youtube.com/c/underjord\" rel=\"nofollow noopener\" translate=\"no\" target=\"_blank\"><span class=\"invisible\">https://</span><span class=\"\">youtube.com/c/underjord</span><span class=\"invisible\"></span></a>",
                "verified_at" => nil
              }
            ],
            "followers_count" => 797,
            "following_count" => 419,
            "group" => false,
            "header" =>
              "https://files.mastodon.social/cache/accounts/headers/114/426/151/375/742/207/original/b687f68e7731de54.jpeg",
            "header_static" =>
              "https://files.mastodon.social/cache/accounts/headers/114/426/151/375/742/207/original/b687f68e7731de54.jpeg",
            "hide_collections" => false,
            "id" => "114426151375742207",
            "indexable" => true,
            "last_status_at" => "2025-12-09",
            "locked" => false,
            "note" =>
              "<p>Code creative, 10x talker, Elixir, BEAM, open source/standards/platforms, he/him, part librarian.</p>",
            "statuses_count" => 401,
            "uri" => "https://hachyderm.io/users/lawik",
            "url" => "https://hachyderm.io/@lawik",
            "username" => "lawik"
          },
          "card" => %{
            "author_name" => "",
            "author_url" => "",
            "authors" => [],
            "blurhash" => "UA9QUDx?9Y-=_N?HVtXT%hxtROWF%hRiIUt7",
            "description" =>
              "Nerves, Membrane, cameras, WiFi hacking. All in the service of drones. Damir brought the perfect way to wrap up NervesConf EU.",
            "embed_url" => "",
            "height" => 360,
            "html" => "",
            "image" =>
              "https://files.mastodon.social/cache/preview_cards/images/173/794/924/original/0470aa8f5fcccf61.jpg",
            "image_description" => "",
            "language" => "en",
            "provider_name" => "",
            "provider_url" => "",
            "published_at" => nil,
            "title" => "Fly me a camera -  Damir Batinović",
            "type" => "link",
            "url" => "https://goatmire.bold.video/v/w5vve",
            "width" => 640
          },
          "content" =>
            "<p>Fly me to the moon and let me film among the stars.</p><p>Not quite into space. Damir takes us down the rabbit hole of drones, cameras, hacked wifi drivers and Nerves. Live demos and all.<br><a href=\"https://goatmire.bold.video/v/w5vve\" rel=\"nofollow noopener\" translate=\"no\" target=\"_blank\"><span class=\"invisible\">https://</span><span class=\"\">goatmire.bold.video/v/w5vve</span><span class=\"invisible\"></span></a><br><a href=\"https://hachyderm.io/tags/goatmire\" class=\"mention hashtag\" rel=\"nofollow noopener\" target=\"_blank\">#<span>goatmire</span></a> <a href=\"https://hachyderm.io/tags/elixir\" class=\"mention hashtag\" rel=\"nofollow noopener\" target=\"_blank\">#<span>elixir</span></a></p>",
          "created_at" => "2025-12-09T10:00:48.000Z",
          "edited_at" => nil,
          "emojis" => [],
          "favourites_count" => 1,
          "id" => "115689026414523201",
          "in_reply_to_account_id" => nil,
          "in_reply_to_id" => nil,
          "language" => "en",
          "media_attachments" => [],
          "mentions" => [],
          "poll" => nil,
          "quote" => nil,
          "quote_approval" => %{
            "automatic" => ["public"],
            "current_user" => "denied",
            "manual" => []
          },
          "quotes_count" => 0,
          "reblog" => nil,
          "reblogs_count" => 0,
          "replies_count" => 1,
          "sensitive" => false,
          "spoiler_text" => "",
          "tags" => [
            %{
              "name" => "goatmire",
              "url" => "https://mastodon.social/tags/goatmire"
            },
            %{
              "name" => "elixir",
              "url" => "https://mastodon.social/tags/elixir"
            }
          ],
          "uri" => "https://hachyderm.io/users/lawik/statuses/115689026280236444",
          "url" => "https://hachyderm.io/@lawik/115689026280236444",
          "visibility" => "public"
        }
      ]
    end
  end
end
