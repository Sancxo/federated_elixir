# FederatedElixir

This is a test project made with Elixir and Phoenix. The goal of this is to provide fresh Elixir-related content from the [Fediverse](https://jointhefediverse.net) provided by the [Mastodon](https://joinmastodon.org/) API.

## Initialization 

Before starting the server, it is mandatory to install [`docker`](https://www.docker.com/) if you don't have it yet.

After cloning the repository on your computer, to start the server:

* In a terminal, go to the project folder (`cd PATH\TO\FOLDER\federated_elixir`) and run `docker compose up`
* In another terminal (still inside the project folder), run `mix setup` to install and setup dependencies (it is a little long as there is a lot of mocked users )
* Then start Phoenix endpoint with `mix phx.server`.

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
