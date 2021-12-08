points = map(str -> [parse(Int64,str[l]) for l in findall(r"[[:digit:]]+", str)], readlines("inputs/05.txt"))

grid = zeros(Int64, 1000,1000);

smart_range(x1, x2) = x1:(x2 > x1 ? 1 : -1):x2

function smart_2d_range(x1, y1, x2, y2)
  x,y = smart_range(x1, x2), smart_range(y1, y2)
  if x1 == x2
    x = Iterators.repeated(x.start, length(y))
  elseif y1 == y2
    y = Iterators.repeated(y.start, length(x))
  end
  return zip(x, y)
end

function day5p2(points) 
  for p in points
    for (x,y) in smart_2d_range(p...)
      grid[x,y] += 1
    end
  end

  count(i -> i > 1, grid)
end

using BenchmarkTools
@btime day5p2(points)