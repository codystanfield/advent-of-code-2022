{:ok, data} = File.read('input.txt')
lines = String.split(data, "\n")

[diagram, _, movements, _] = Enum.chunk_by(lines, fn line -> line == "" end)

build_stack = fn diagram, column ->
  # 1 -> 1
  # 2 -> 5
  # 3 -> 9
  # 4 -> 13
  # ...
  idx = (column - 1) * 3 + column

  reversed_stack =
    Enum.reduce(diagram, [], fn line, acc ->
      case String.at(line, idx) do
        " " ->
          acc

        box ->
          [box | acc]
      end
    end)

  # Remove column number, reverse stack
  [_ | reversed_stack] = reversed_stack
  Enum.reverse(reversed_stack)
end

stacks = Enum.map(1..9, fn stack -> build_stack.(diagram, stack) end)

parse_instruction = fn instruction ->
  [_, count, source, destination] = Regex.run(~r/^move (\d+) from (\d+) to (\d+)$/, instruction)
  count = String.to_integer(count)
  source = String.to_integer(source)
  destination = String.to_integer(destination)
  {count, source, destination}
end

move_single_boxes = fn instruction, stacks ->
  {count, source, destination} = parse_instruction.(instruction)

  Enum.reduce(1..count, stacks, fn _, acc ->
    source_stack = Enum.at(acc, source - 1)
    dest_stack = Enum.at(acc, destination - 1)
    [popped | source_stack] = source_stack
    dest_stack = [popped | dest_stack]

    Enum.map(Enum.with_index(acc), fn {stack, idx} ->
      cond do
        idx == source - 1 ->
          source_stack

        idx == destination - 1 ->
          dest_stack

        true ->
          stack
      end
    end)
  end)
end

top_boxes =
  Enum.reduce(movements, stacks, fn instruction, acc -> move_single_boxes.(instruction, acc) end)
  |> Enum.map(&hd/1)

IO.puts(top_boxes)

##########
# PART 2 #
##########

move_multiple_boxes = fn instruction, stacks ->
  {count, source, destination} = parse_instruction.(instruction)

  source_stack = Enum.at(stacks, source - 1)
  dest_stack = Enum.at(stacks, destination - 1)

  popped = Enum.slice(source_stack, 0..(count - 1))
  source_stack = Enum.slice(source_stack, count..Enum.count(source_stack))
  dest_stack = popped ++ dest_stack

  Enum.map(Enum.with_index(stacks), fn {stack, idx} ->
    cond do
      idx == source - 1 ->
        source_stack

      idx == destination - 1 ->
        dest_stack

      true ->
        stack
    end
  end)
end

top_boxes =
  Enum.reduce(movements, stacks, fn instruction, acc -> move_multiple_boxes.(instruction, acc) end)
  |> Enum.map(&hd/1)

IO.puts(top_boxes)
