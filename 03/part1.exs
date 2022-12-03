File.read!("03/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn line ->
  mid = trunc(String.length(line) / 2)

  [first, second] =
    for section <- String.split_at(line, mid) |> Tuple.to_list() do
      String.to_charlist(section) |> MapSet.new()
    end

  for char <- MapSet.intersection(first, second) do
    case char do
      # A-Z -> 27-52
      c when c in 65..90 -> c - 38
      # a-z -> 1-26
      c when c in 97..122 -> c - 96
    end
  end
  |> Enum.sum()
end)
|> Enum.sum()
|> IO.puts()
