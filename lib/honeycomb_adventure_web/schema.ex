defmodule HoneycombAdventureWeb.Schema do
  use Absinthe.Schema
  use Absinthe.Schema.Notation
  alias HoneycombAdventure.User

  query do
    field :users, list_of(:user) do
      resolve fn _parent, _args, _resolution ->
        {:ok, User.list()}
      end
    end
    field :user, :user do
      arg :id, non_null(:id)
      resolve fn %{id: id}, _resolution ->
        case User.get(id) do
          nil ->
            {:error, "User not found, id: #{id}."}
          user ->
            {:ok, user}
        end
      end
    end
  end

  mutation do
    field :join_room, :user do
      arg :user_id, non_null(:id)
      arg :room_id, non_null(:id)
      resolve fn _parent, %{user_id: user_id, room_id: room_id}, _resolution ->
        {:ok, %{id: user_id, room_id: room_id, account: "test"}}
      end
    end
  end

  subscription do
    field :user_join, :user do
      arg :room_id, non_null(:id)
  
      config fn args, _ ->
        {:ok, topic: args.room_id}
      end
  
      trigger :join_room, topic: fn user ->
        user.room_id
      end
  
      resolve fn user, _, _ ->
        {:ok, user}
      end
    end
  end

  @desc "An user info"
  object :user do
    field :id, :id
    field :room_id, :id
    field :account, :string
  end
end