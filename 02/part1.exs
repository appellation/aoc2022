# A, X: rock
# B, Y: paper
# C, Z: scissors

wins = %{
  "A" => "Y",
  "B" => "Z",
  "C" => "X"
}

draws = %{
  "A" => "X",
  "B" => "Y",
  "C" => "Z"
}

scores = %{
  "X" => 1,
  "Y" => 2,
  "Z" => 3
}

File.read!("02/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn l ->
  [opp, me] = String.split(l, " ")
  win = wins[opp]
  draw = draws[opp]

  case me do
    ^win -> 6
    ^draw -> 3
    _ -> 0
  end + scores[me]
end)
|> Enum.sum()
|> IO.puts()
