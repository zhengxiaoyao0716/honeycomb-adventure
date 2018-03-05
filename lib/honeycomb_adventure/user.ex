defmodule HoneycombAdventure.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query
  alias HoneycombAdventure.User
  alias HoneycombAdventure.Repo


  schema "user" do
    field :code, :string
    field :secret, :string
    field :name, :string
    field :phone, :string
    field :email, :string
    field :extra, :map
    field :signin_at, :date

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:code, :secret, :name, :phone, :email, :extra, :signin_at])
    |> validate_length(:code, min: 2)
    |> validate_length(:code, max: 20)
    |> validate_length(:name, min: 2)
    |> validate_length(:name, max: 20)
    |> validate_format(:email, ~r/@/)
  end

  def set_password(%User{} = user, attrs) do
    attrs =
      attrs
      |> Map.put(:secret, Comeonin.Argon2.hashpwsalt(attrs.password))
      |> Map.put(:signin_at, Date.utc_today)
    user
    |> cast(attrs, [:secret, :signin_at])
  end
  def check_password(%User{} = user, attrs) do
    attrs = attrs |> Map.put(:signin_at, Date.utc_today)
    user
    |> cast(attrs, [:secret, :signin_at])
    |> validate_required(:secret)
    |> validate_match(:secret)
  end

  def get(id), do: User |> Repo.get(id)
  def list(), do: User |> Repo.all

  @word_letters [?0..?9, ?A..?Z, ?a..?z]
  @doc """
  Generate random code, only includes the following letters: 
  #{@word_letters |> Stream.concat |> Enum.to_list}
  """
  def rand_code(size \\ 6), do: @word_letters |> Stream.concat |> Enum.take_random(size)
  
  @spec validate_match(Changeset, atom, Keyword.Changeset) :: Changeset
  defp validate_match(%{changes: changes, params: params} = changeset, field, opts \\ []) do
    if Map.has_key?(changes, field) do
      add_error(changeset, :password, "password not match")
    else
      changeset
    end
  end
end
