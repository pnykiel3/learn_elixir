defmodule Pokedex do
  def search(name) do
    url = "https://pokeapi.co/api/v2/pokemon/#{name}"

    case Req.get(url) do

      {:ok, %{status: 200, body: body} } ->
        pokemon_name = body["name"]
        pokemon_weight = body["weight"]
        pokemon_height = body["height"]
        IO.puts("Pokemon #{pokemon_name} weights #{pokemon_weight} and is #{pokemon_height} height")

      {:ok, %{status: 404}} ->
        IO.puts("Pokemon #{name} not found")

      {:error, reason} ->
        IO.puts("An error occured: #{reason}")
    end
  end
end
