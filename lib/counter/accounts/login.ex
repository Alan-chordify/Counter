defmodule Counter.Accounts.Login do
  use Ecto.Schema
  import Ecto.Changeset

  schema "logins" do
    field :password, :string
    field :email, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(login, attrs) do
    login
    |> cast(attrs, [:email, :password])
    |> validate_required([:email, :password])
  end
end
