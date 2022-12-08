File.read!("07/input.txt")
|> String.split("\n", trim: true)
|> Enum.reduce({%{}, []}, fn line, {tree, cur} ->
  case line do
    "$ cd /" ->
      {tree, []}

    "$ cd .." ->
      {tree, tl(cur)}

    "$ cd " <> dir ->
      {tree, [dir | cur]}

    "$ ls" ->
      {tree, cur}

    "dir " <> name ->
      {Map.put_new(tree, [name | cur], 0), cur}

    other ->
      [size, _] = String.split(other, " ")
      size = String.to_integer(size)

      paths =
        Stream.unfold(cur, fn
          nil -> nil
          [] -> {[], nil}
          acc -> {acc, tl(acc)}
        end)

      new_tree =
        Enum.reduce(paths, tree, fn path, tree ->
          Map.update(tree, path, size, &(&1 + size))
        end)

      {new_tree, cur}
  end
end)
|> elem(0)
|> then(fn tree ->
  total = Map.get(tree, [])
  min_to_delete = total - 40_000_000

  Map.values(tree)
  |> Enum.sort(:asc)
  |> Enum.find(fn v -> v >= min_to_delete end)
end)
|> IO.puts()
