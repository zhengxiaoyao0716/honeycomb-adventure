defmodule HoneycombAdventure.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias HoneycombAdventure.User
  alias HoneycombAdventure.Repo


  schema "user" do
    field :account, :string
    field :secret, :string
    field :name, :string
    field :phone, :string
    field :email, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    # attrs =
    #   attrs
    #   |> Map.put(:secret, Comeonin.Argon2.hashpwsalt(attrs.password))
    attrs =
      attrs
      |> Map.put(:secret, attrs[:password])
    user
    |> cast(attrs, [:account, :secret, :name, :phone, :email])
    |> validate_required([:account])
    |> validate_length(:account, min: 2)
    |> validate_length(:account, max: 20)
    |> validate_length(:name, min: 2)
    |> validate_length(:name, max: 20)
    |> validate_format(:email, ~r/@/)
  end

  def get(id) do
    Repo.get(User, id)
  end
  def list() do
    from(u in User)
    |> Repo.all
  end
end
