{:ok, data} = File.read('input.txt')
lines = String.split(data, "\n", trim: true)

res = Enum.map(lines, &String.split(&1, ","))
  |> Enum.map(fn [left, right] ->
    {String.split(left, "-"), String.split(right, "-")}
  end)
  |> Enum.map(fn {[a, b], [c, d]} ->
    {[String.to_integer(a), String.to_integer(b)], [String.to_integer(c), String.to_integer(d)]}
  end)
  |> Enum.filter(fn {[a, b], [c, d]} ->
    cond do
      (a <= c) and (b >= d) ->
        true
      (c <= a) and (d >= b) ->
        true
      true ->
        false
    end
  end)
  |> Enum.count()

IO.inspect(res)

########
# PART 2
########

res = Enum.map(lines, &String.split(&1, ","))
  |> Enum.map(fn [left, right] ->
    {String.split(left, "-"), String.split(right, "-")}
  end)
  |> Enum.map(fn {[a, b], [c, d]} ->
    {[String.to_integer(a), String.to_integer(b)], [String.to_integer(c), String.to_integer(d)]}
  end)
  |> Enum.filter(fn {[a, b], [c, d]} ->
    cond do
      (a <= c) and (c <= b) ->
        true
      (c <= a) and (a <= d) ->
        true
      true ->
        false
    end
  end)
  |> Enum.count()

IO.inspect(res)
