defmodule FakeFile do
  defstruct [:name, :type, :parent_directory, :size]
end

data = File.read!('input.txt')
lines = String.split(data, "\n", trim: true)


Enum.reduce(0..Enum.count(lines), {}, fn line, acc ->
  case line do
    {}
  end
end)




iterate, context object with parent list, list of dirs that have size and child dir info
on loop, add size to all parents
  can do one pass, not worry about child dir info in nodes
