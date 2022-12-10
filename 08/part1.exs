find_visible = fn list ->
  Enum.reduce(list, {[], -1}, fn height, {visible, max_height} ->
    if height > max_height do
      {[true | visible], height}
    else
      {[false | visible], max_height}
    end
  end)
  |> elem(0)
end

get_visibilities = fn row, visibilities ->
  {l, r} = {row, Enum.reverse(row)}

  visible_l = find_visible.(l) |> Enum.reverse()
  visible_r = find_visible.(r)

  [Enum.zip_reduce(visible_l, visible_r, [], fn l, r, acc -> [l or r | acc] end) | visibilities]
end

File.read!("08/input.txt")
|> String.split("\n", trim: true)
|> Enum.map(fn row -> String.split(row, "", trim: true) |> Enum.map(&String.to_integer/1) end)
|> then(fn mat ->
  row_vis = Enum.reduce(mat, [], &get_visibilities.(&1, &2))

  col_vis =
    Enum.zip_reduce(mat, [], &get_visibilities.(&1, &2))
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)

  Enum.zip_reduce(row_vis, col_vis, 0, fn row, col, acc ->
    Enum.zip_reduce(row, col, 0, fn a, b, acc -> acc + if a or b, do: 1, else: 0 end) + acc
  end)
end)
|> IO.puts()
