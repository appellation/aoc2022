# Day 5

https://adventofcode.com/2022/day/5

I learned a lot about keeping state in Elixir. Normally my approach would have been to update the
matrix in-place, but obviously this is impossible when mutability isn't a thing. Therefore, I
learned how to handle state with function calls using reduce.
