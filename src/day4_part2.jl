lines = readlines("inputs/04.txt") # notes: added a newline to the input file
nums = [parse(Int64, x ) for x in split(lines[1], ',')]
lines = lines[2:end]

function parse_grids(lines)
  grids = []
  for i in 2:6:length(lines)-4
    grid = zeros(Int64, 5,5)
    gridstrs = lines[i:i+4]
    for (r_i, r) in enumerate(gridstrs)
      grid[r_i,:] = [parse(Int64, x) for x in filter(q -> length(q) > 0 ,split(strip(r), ' '))]
    end
    push!(grids, grid)
  end
  return grids
end

is_bingo(grid) = 500 in sum(grid, dims = 1) || 500 in sum(grid, dims = 2)

score(n, grid) = n * (sum(grid) - (100 * count(i -> i == 100, grid)))

function day3(nums, grids_)
  grids = copy(grids_)
  for num in nums
    grids = map(g -> replace(g, num => 100), grids)
    to_del = []
    for (g_i, g) in enumerate(grids)
      if is_bingo(g)
        if length(grids) == 1
          return score(num, grids[1])
        else
          push!(to_del, g_i)
        end
      end
    end
    deleteat!(grids, to_del)
  end
end

grids = parse_grids(lines)
println(day3(nums, grids))
