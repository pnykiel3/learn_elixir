defmodule Pokedex do
  def search(name) do
    name |> build_url() |> Req.get() |> handle_response()
  end

  defp build_url(name) do
    "https://pokeapi.co/api/v2/pokemon/#{name}"
  end

  defp handle_response({:ok, %{status: 200, body: body}}) do
    pokemon_name = body["name"]
    pokemon_weight = body["weight"]
    pokemon_height = body["height"]
    IO.puts("Pokemon #{pokemon_name} weights #{pokemon_weight} and is #{pokemon_height} height")
    types = body["types"] |> Enum.map(fn t -> t["type"]["name"] end) |> Enum.join(", ")
    IO.puts("Pokemon types are #{types}")
  end

  defp handle_response({:ok, %{status: 404}}) do
    IO.puts("Pokemon not found")
  end

  defp handle_response({:error, _reason}) do
    IO.puts("An error occured")
  end
end
