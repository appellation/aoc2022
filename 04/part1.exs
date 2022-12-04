File.read!("04/input.txt")
|> String.split("\n", trim: true)
|> Enum.count(fn line ->
  [first, second] =
    for pair <- String.split(line, ",") do
      [start, end_] = String.split(pair, "-") |> Enum.map(&String.to_integer/1)
      start..end_ |> MapSet.new()
    end

  MapSet.subset?(first, second) || MapSet.subset?(second, first)
end)
|> IO.puts()
