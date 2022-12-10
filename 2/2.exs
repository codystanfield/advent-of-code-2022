{:ok, data} = File.read('input.txt')
lines = String.split(data, "\n")
rounds = Enum.map(lines, &String.split/1)

rock = 1
paper = 2
scissors = 3
win = 6
lose = 0
draw = 3

expected_score = Enum.reduce(rounds, 0, fn round, acc ->
  case round do
    ["A", "X"] ->
      acc + rock + draw
    ["A", "Y"] ->
      acc + paper + win
    ["A", "Z"] ->
      acc + scissors + lose

    ["B", "X"] ->
      acc + rock + lose
    ["B", "Y"] ->
      acc + paper + draw
    ["B", "Z"] ->
      acc + scissors + win

    ["C", "X"] ->
      acc + rock + win
    ["C", "Y"] ->
      acc + paper + lose
    ["C", "Z"] ->
      acc + scissors + draw

    _ -> acc
  end
end)

IO.puts(expected_score)

########
# PART 2
########

expected_score = Enum.reduce(rounds, 0, fn round, acc ->
  case round do
    ["A", "X"] ->
      acc + scissors + lose
    ["A", "Y"] ->
      acc + rock + draw
    ["A", "Z"] ->
      acc + paper + win

    ["B", "X"] ->
      acc + rock + lose
    ["B", "Y"] ->
      acc + paper + draw
    ["B", "Z"] ->
      acc + scissors + win

    ["C", "X"] ->
      acc + paper + lose
    ["C", "Y"] ->
      acc + scissors + draw
    ["C", "Z"] ->
      acc + rock + win

    _ -> acc
  end
end)

IO.puts(expected_score)
