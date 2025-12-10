# FederatedElixir

This is a test project made with Elixir and Phoenix. The goal of it is to provide fresh Elixir-related content from the [Fediverse](https://jointhefediverse.net) provided by the [Mastodon](https://joinmastodon.org/) API.

## Initialization 

Before starting the server, it is mandatory to install [`docker`](https://www.docker.com/) if you don't have it yet.

After cloning the repository on your computer, to start the server:

* In a terminal, go to the project folder (`cd PATH\TO\FOLDER\federated_elixir`) and run `docker compose up`
* In another terminal (still inside the project folder), run `mix setup` to install and setup dependencies (it is a little long as there is a lot of mocked users )
* Then start Phoenix endpoint with `mix phx.server`.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Tests and quality checks

This project uses `Credo` and `exCoveralls` for code hygiene and coverage. To run these quality checks alongside tests, just run `mix quality`. Others commands are :

- `mix test` for tests only,
- `mix coveralls` for code coverage only,
- `mix coveralls.detail --filter PATH/TO/FILE.ex` to highlight the tested and untested parts of a file,
- `mix credo` for quality check,

## Improvements

- Mastodon API provide a route to stream timelines, this is an opportunity to create a websocket and having real-time notifications each time a new post is published on the Fediverse with an `#elixir` hashtag ; this would display a call to action to refresh the feed.
- Another interesting idea would be to integrate the Mastodon API authentication instead of the Phoenix one. This would delegate the authentication process to the server hosting the user account, but also allow the user to interact with the posts displayed (like, repost, bookmark, comment, etc). 