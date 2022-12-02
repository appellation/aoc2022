File.read!("01/input.txt")
|> String.split("\n\n", trim: true)
|> Enum.map(fn l ->
  String.split(l, "\n", trim: true)
  |> Enum.map(&String.to_integer/1)
  |> Enum.sum()
end)
|> Enum.max()
|> IO.puts()
