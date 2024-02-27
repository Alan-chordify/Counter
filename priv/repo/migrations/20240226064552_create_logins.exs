defmodule Counter.Repo.Migrations.CreateLogins do
  use Ecto.Migration

  def change do
    create table(:logins) do
      add :name, :string
      add :email, :string
      add :password, :string

      timestamps(type: :utc_datetime)
    end
  end
end
