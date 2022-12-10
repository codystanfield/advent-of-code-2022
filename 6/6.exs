data = File.read!('input.txt')
line = String.trim(data)

idx =
  Enum.find(0..String.length(line), fn idx ->
    count =
      String.slice(line, (idx - 4)..(idx - 1))
      |> String.to_charlist()
      |> MapSet.new()
      |> Enum.count()

    count == 4
  end)

IO.inspect(idx)
