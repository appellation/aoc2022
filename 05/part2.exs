{rows, moves} =
  File.read!("05/input.txt")
  |> String.split("\n")
  |> Enum.split_while(fn line -> line != "" end)

cols =
  Enum.slice(rows, 0..-2)
  |> Enum.map(fn line ->
    String.to_charlist(line)
    |> Enum.chunk_every(4)
    |> Enum.reduce([], fn col, mat ->
      name = Enum.at(col, 1)
      mat ++ [name]
    end)
  end)
  |> Enum.zip_reduce([], fn chars, acc ->
    [Enum.filter(chars, fn c -> c != ?\s end) | acc]
  end)
  |> Enum.reverse()

moves =
  Enum.slice(moves, 1..-2)
  |> Enum.map(fn line ->
    [count, from_idx, to_idx] =
      String.split(line, " ", trim: true)
      |> Enum.drop_every(2)
      |> Enum.map(&String.to_integer/1)

    {count, from_idx - 1, to_idx - 1}
  end)

Enum.reduce(moves, cols, fn {count, from_idx, to_idx}, new_cols ->
  from = Enum.at(new_cols, from_idx)
  to = Enum.at(new_cols, to_idx)

  {chunk, new_from} = Enum.split(from, count)
  new_to = chunk ++ to

  List.replace_at(new_cols, from_idx, new_from) |> List.replace_at(to_idx, new_to)
end)
|> Enum.map(&List.first/1)
|> IO.puts()
