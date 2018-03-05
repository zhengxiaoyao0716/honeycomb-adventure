defmodule HoneycombAdventure.Repo.Migrations.UpdateUser do
  use Ecto.Migration

  def change do
    alter table(:user) do
      add :extra, :map
      add :signin_at, :date
    end
  end
end
