# Day 1

https://adventofcode.com/2022/day/1

## Part 1

Really only one way to do this.

## Part 2

I considered using a priority queue, but it doesn't seem worth it. To build a priority queue of the
entire set requires O(N log N) time complexity: N to iterate over the list and log(N/2) to insert
each element. This is equivalent to the average sort case.

A marginal improvement might be to maintain a capped priority queue of 3 elements. Technically a
capped queue is O(1), making the entire process O(N).
