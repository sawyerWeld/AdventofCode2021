lines = readlines("inputs/6-10/09.txt")
nums = [[parse(Int, x) for x in line] for line in lines]

# gets position (r,c) of 2D vec grid, or 9 if out of bounds
function getat(r,c,grid,fallback=9)
  h = length(grid)
  w = length(grid[1])
  if r < 1 || c < 1 || r > h || c > w
    return fallback
  end
  return nums[r][c]
end

function part1(nums)
  t = 0
  for r in 1:length(nums), c in 1:length(nums[1])
    val = nums[r][c]
    if val < getat(r-1,c, nums) &&  val < getat(r+1,c, nums) &&  val < getat(r,c-1, nums) &&  val < getat(r,c+1, nums)
      t += val + 1
    end 
  end
  t
end

# unique identifier for an x,y pair
f(x, y) = (100 * x) + y

function part2(nums)
  g = SimpleGraph(10000)

  for r in 1:length(nums)
    for c in 1:length(nums[1])
      if nums[r][c] == 9
        continue
      end
      for (dc, dr) in [(0, -1), (0, 1), (-1, 0), (1, 0)]
        # gets nums[r + dr][c + dc] or 9 if out of bounds
        if getat(r + dr, c + dc, nums, 9)  != 9 
          add_edge!(g, f(r, c), f(r + dr, c + dc))
        end
      end
    end
  end

  lens = [length(cc) for cc in connected_components(g)] |> sort
  lens[end] * lens[end-1] * lens[end-2]
end
