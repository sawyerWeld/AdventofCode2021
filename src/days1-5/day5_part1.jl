lines = readlines("inputs/05.txt")
function day_5(lines) 
  grid = zeros(Int64, 1000,1000)
  pairs = []

  for line in lines
    x1 = parse(Int64, split(line,',')[1])
    y2 = parse(Int64, split(line,',')[3])
    mid = split(line,',')[2]
    y1 = parse(Int64, split(mid, ' ')[1])
    x2 = parse(Int64, split(mid, ' ')[3])
    push!(pairs, [x1, y1, x2, y2])
  end

  for p in pairs
    x1, y1, x2, y2 = p
    if x1 == x2 
      for y in min(y1, y2):max(y1, y2)
        grid[x1, y] += 1
      end
    elseif y1 == y2 
      for x in min(x1, x2):max(x1, x2)
        grid[x, y1] += 1
      end
    end
  end
  count(i -> i > 1, grid)
end

println(day_5(lines))
