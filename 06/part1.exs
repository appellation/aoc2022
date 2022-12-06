idx =
  File.read!("06/input.txt")
  |> String.to_charlist()
  |> Enum.chunk_every(4, 1, [])
  |> Enum.find_index(fn chars -> Enum.uniq(chars) == chars end)

IO.puts(idx + 4)
