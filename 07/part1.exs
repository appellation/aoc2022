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
|> Map.values()
|> Enum.filter(fn v -> v <= 100_000 end)
|> Enum.sum()
|> IO.puts()
