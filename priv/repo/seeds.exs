# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     FederatedElixir.Repo.insert!(%FederatedElixir.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias FederatedElixir.Accounts.User
alias FederatedElixir.Repo

for index <- 1..20_000 do
  Repo.insert!(%User{
    email: "user-#{index}@mail.com",
    subscribe_to_newsletter: true,
    confirmed_at: DateTime.utc_now(:second)
  })
end
