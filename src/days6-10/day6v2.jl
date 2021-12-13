using BenchmarkTools
using StaticArrays
# this is a slower but pretty solution. took inspiration from a reddit comment

const start = SVector{300}(map(str -> [parse(Int,str[l]) for l in findall(r"[[:digit:]]+", str)], readlines("inputs/6-10/06.txt"))[1])

function day6(start, days)
  c = zeros(Int, 9)
  for x in start
    c[x] += 1
  end
  for _ in 1:days-1
    c = circshift(c, -1)
    c[7] += c[end]
  end
  sum(c)
end

println("Day 6 Part 1: ",day6(start, 80))
println("Day 6 Part 2: ",day6(start, 256))


const A = SMatrix{9,9}([
 0  1  0  0  0  0  0  0  0
 0  0  1  0  0  0  0  0  0
 0  0  0  1  0  0  0  0  0
 0  0  0  0  1  0  0  0  0
 0  0  0  0  0  1  0  0  0
 0  0  0  0  0  0  1  0  0
 1  0  0  0  0  0  0  1  0
 0  0  0  0  0  0  0  0  1
 1  0  0  0  0  0  0  0  0
])


function day6transition( days)
  c = zeros(Int, 9)
  for x in start
    c[x] += 1
  end
  StC = SVector{9}(c)
  (A^days) * StC |> sum
end

@btime day6transition( 256)
