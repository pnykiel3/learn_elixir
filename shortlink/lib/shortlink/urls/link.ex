defmodule Shortlink.Urls.Link do
  use Ecto.Schema
  import Ecto.Changeset

  schema "links" do
    field :original_url, :string
    field :hash, :string
    field :clicks, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:original_url, :hash, :clicks])
    |> validate_required([:original_url, :hash, :clicks])
    |> unique_constraint(:hash)
  end
end
