# nums = [[parse(Int64, l) for l in line] for line in readlines("inputs/04.txt")]
lines = readlines("inputs/04.txt")

nums = lines[1]
nums = [parse(Int64, x ) for x in split(nums, ',')]

lines = lines[2:end]

grids = []
for i in 2:6:length(lines)-4
  println(lines[i:i+5])
  grid = zeros(Int64, 5,5)
  gridstrs = lines[i:i+4]
  for (r_i, r) in enumerate(gridstrs)
    row_vec = [parse(Int64, x) for x in filter(q -> length(q) > 0 ,split(strip(r), ' '))]
    grid[r_i,:] = row_vec
  end
  push!(grids, grid)
end

function day3(nums, grids_)
  grids = copy(grids_)
  for num in nums
    grids = map(g -> replace(g, num => 100), grids)
    for g in grids
      if is_bingo(g)
        print(g)
        println(sum(g) - (100 * count(i -> i==100, g1)))
        println("last num: ", num)
        return g
      end
    end
  end
end
gx = day3(nums, grids)

function is_bingo(grid)
  if 500 in sum(grid, dims = 1) || 500 in sum(grid, dims = 2)
    return true 
  end
  # if sum([grid[i,i] for i in 1:5]) == 500 || sum([grid[5,1], grid[4,2], grid[3,3], grid[2,4], grid[1,5]]) == 500
  #   return true
  # end
  return false
end