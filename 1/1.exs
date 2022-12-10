{:ok, data} = File.read('input.txt')
lines = String.split(data, "\n")

elves_lists = Enum.reduce(lines, [[]], fn line, acc ->
  case line do
    "" ->
      [[] | acc]
    num ->
      [elf_food_list | tail] = acc
      updated_food_list = [String.to_integer(num) | elf_food_list]
      [updated_food_list | tail]
  end
end)

# IO.inspect(elves_lists, charlists: :as_lists)

# NOTE AFTER THE FACT: the problem didn't require the lists to be reversed, I figured part 2 would need it, but nope
# Reverse inner lists
elves_lists = Enum.map(elves_lists, &Enum.reverse/1)
# Reverse list of lists
elves_lists = Enum.reverse(elves_lists)

# Max sum
max = Enum.reduce(elves_lists, 0, fn list, max ->
  sum = Enum.sum(list)
  if sum > max do sum else max end
end)

IO.puts("Max calories: #{max}")

########
# PART 2
########
elves_calories = Enum.map(elves_lists, &Enum.sum/1)
sorted_calories = Enum.sort(elves_calories, &(&1 >= &2))  # Need the function, otherwise sorts ascending
[first | tail] = sorted_calories
[second | tail] = tail
[third | _] = tail

IO.puts(first + second + third)
