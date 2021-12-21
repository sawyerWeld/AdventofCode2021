using DataStructures

lines = readlines("inputs/11-15/15.txt")
# lines = readlines("inputs/11-15/15ex.txt")

M = zeros(Int, length(lines),length(lines[1]))
for (i,l) in enumerate(lines)
  for (j,c) in enumerate(split(l,""))
    # @show c
    M[i,j] = parse(Int,String(c))
  end
end

# is (x,y) a valid coord in matrix A?
inrange((x,y),A) = x in 1:size(A,1) && y in 1:size(A,2)

q = [(0,1,1)]
costs = Dict()
while true
  global q
  cost,x,y = q[1]
  if x==size(M)[1] && y==size(M)[2]
    @show cost
    break
  end
  popfirst!(q) 
  for (dx,dy) ∈ [(-1,0), (1,0), (0,1), (0,-1)]
    if inrange((x+dx,y+dy),M)
      ncost = cost + M[x+dx,y+dy]
      if (x+dx,y+dy) ∈ keys(costs) && costs[(x+dx,y+dy)] <= ncost
        continue
      end
      costs[(x+dx,y+dy)] = ncost
      push!(q,(ncost,x+dx,y+dy))
    end
  end
  q = sort(q)
end

