
targetarea = "target area: x=244..303, y=-91..-54"

part1(y) = abs(y) * (abs(y)-1)/2

function part2(xmin,xmax,ymin,ymax)
  t = 0
  for dx in 0:xmax+1, dy in ymin:-ymin
    x = 0
    y = 0
    vx = dx
    vy = dy
    while x <= xmax && y >= ymin
      if x >= xmin && y <= ymax
        t += 1
        break
      end
      x,y = (x + vx, y + vy)
      vy -= 1
      if vx > 0
        vx -= 1
      end
    end
  end
  t
end

@show part1(-91)
@show part2(244,303,-91,-54)

using BenchmarkTools
@btime part2(244,303,-91,-54)
