data = File.read!('input.txt')
line = String.trim(data)

find_idx = fn unique_chars_needed, line ->
  Enum.find(0..String.length(line), fn idx ->
    count =
      String.slice(line, (idx - unique_chars_needed)..(idx - 1))
      |> String.to_charlist()
      |> MapSet.new()
      |> Enum.count()

    count == unique_chars_needed
  end)
end

idx = find_idx.(4, line)
IO.inspect(idx)

##########
# PART 2 #
##########

# Is this efficient? Probably not. I'm not doing it the imperative way though
# Looks fine
# $ time elixir 6.exs
#   real  0m0.370s
#   user  0m0.434s
#   sys	  0m0.034s
idx = find_idx.(14, line)
IO.inspect(idx)
