defmodule Shortlink.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links) do
      add :original_url, :string
      add :hash, :string
      add :clicks, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
