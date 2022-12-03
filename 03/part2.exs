File.read!("03/input.txt")
|> String.split("\n", trim: true)
|> Enum.chunk_every(3)
|> Enum.map(fn group ->
  [common] =
    for line <- group do
      String.to_charlist(line) |> MapSet.new()
    end
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()

  case common do
    # A-Z -> 27-52
    c when c in 65..90 -> c - 38
    # a-z -> 1-26
    c when c in 97..122 -> c - 96
  end
end)
|> Enum.sum()
|> IO.puts()
