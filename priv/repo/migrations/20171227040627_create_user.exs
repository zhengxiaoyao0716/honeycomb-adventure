defmodule HoneycombAdventure.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:user) do
      add :account, :string
      add :secret, :string
      add :name, :string
      add :phone, :string
      add :email, :string

      timestamps()
    end

  end
end
