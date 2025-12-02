defmodule FederatedElixir.Repo.Migrations.AlterUsersAddSubscribeToNewsletter do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :subscribe_to_newsletter, :boolean, default: false
    end
  end
end
