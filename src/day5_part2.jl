lines = readlines("inputs/05.txt")
grid = zeros(Int64, 1000,1000);
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
  else # remove this else to get part 1 solution
    for (x,y) in zip(x1:(x2 > x1 ? 1 : -1):x2, y1:(y2 > y1 ? 1 : -1):y2)
      grid[x,y] += 1
    end
  end
end

println(count(i -> i > 1, grid))
