# I'm not going to bother with modules to define functions, sue me

{:ok, data} = File.read('input.txt')
lines = String.split(data, "\n")

res =
  # Filter empty line
  Enum.filter(lines, fn line -> line != "" end)
  # Split in half
  |> Enum.map(fn line ->
    String.split_at(line, trunc(String.length(line) / 2))
  end)
  # Create sets of left and right
  |> Enum.map(fn {left, right} ->
    {MapSet.new(String.split(left, "", trim: true)),
     MapSet.new(String.split(right, "", trim: true))}
  end)
  # Find set intersection
  |> Enum.map(fn {left, right} -> MapSet.intersection(left, right) end)
  # Convert to ascii val
  |> Enum.map(&MapSet.to_list/1)
  |> Enum.map(&hd/1)
  |> Enum.map(&String.to_charlist/1)
  |> Enum.map(&hd/1)
  # Convert ascii to priority
  |> Enum.map(fn val ->
    case val do
      x when x > 96 ->
        x - 96
      x when x > 64 ->
        x - 38
    end
  end)
  # Sum priorities
  |> Enum.sum()

IO.inspect(res)

########
# PART 2
########

res =
  #Filter empty line
  Enum.filter(lines, fn line -> line != "" end)
  # Chunk into groups of 3
  |> Enum.chunk_every(3)
  # Turn each string into a MapSet
  |> Enum.map(fn chunk ->
    Enum.map(chunk, fn list -> String.split(list, "", trim: true) end)
    |> Enum.map(&MapSet.new/1)
  end)
  # Find intersection of sets
  |> Enum.map(fn [first, second, third] ->
    MapSet.intersection(MapSet.intersection(first, second), third)
  end)
  # Convert to ascii val
  |> Enum.map(&MapSet.to_list/1)
  |> Enum.map(&hd/1)
  |> Enum.map(&String.to_charlist/1)
  |> Enum.map(&hd/1)
  # Convert ascii to priority
  |> Enum.map(fn val ->
    case val do
      x when x > 96 ->
        x - 96
      x when x > 64 ->
        x - 38
    end
  end)
  # Sum priorities
  |> Enum.sum()

IO.inspect(res)
