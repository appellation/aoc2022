# A: rock
# B: paper
# C: scissors

# X: lose
# Y: draw
# Z: win

wins = %{
  "A" => :paper,
  "B" => :scissors,
  "C" => :rock
}

draws = %{
  "A" => :rock,
  "B" => :paper,
  "C" => :scissors
}

losses = %{
  "A" => :scissors,
  "B" => :rock,
  "C" => :paper
}

round_scores = %{
  "X" => 0,
  "Y" => 3,
  "Z" => 6
}

play_scores = %{
  :rock => 1,
  :paper => 2,
  :scissors => 3
}

File.read!("02/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn l ->
  [opp, outcome] = String.split(l, " ")
  score = round_scores[outcome]

  case score do
    6 -> play_scores[wins[opp]]
    3 -> play_scores[draws[opp]]
    0 -> play_scores[losses[opp]]
  end + score
end)
|> Enum.sum()
|> IO.puts()
