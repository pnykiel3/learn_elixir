defmodule TextAnalyzer do

  def analyze(book_id) do
    IO.puts("Downloading book number #{book_id} from Project Gutenberg...")
    fetch_book(book_id) |>
    String.downcase() |>
    String.replace(~r/[^\p{L}\s]/u, "") |>
    String.split() |>
    Enum.frequencies() |>
    Enum.sort_by(fn {_word, count} -> count end, :desc) |>
    Enum.take(10) |>
    Enum.each(fn {word, count} -> IO.puts("#{word}: #{count}") end)
  end

  defp fetch_book(book_id) do
    url = "https://www.gutenberg.org/cache/epub/#{book_id}/pg#{book_id}.txt"
    {title, author} = get_data(book_id)
    %{body: text} = Req.get!(url)
    IO.puts("#{title} by #{author} has been successfully downloaded")
    text
  end

  defp get_data(book_id) do
    url = "https://gutendex.com/books/#{book_id}"
    %{body: data} = Req.get!(url)
    title = data["title"]
    author = hd(data["authors"])["name"]
    {title, author}
  end
end
