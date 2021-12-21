# using DataStructures

function readinput(filename)
  lines = readlines(filename)
  M = zeros(Int, length(lines),length(lines[1]))
  for (i,l) in enumerate(lines)
    for (j,c) in enumerate(split(l,""))
      M[i,j] = parse(Int,String(c))
    end
  end
  M
end

function expanded_vals(n)
  S = [
    0 1 2 3 4
    1 2 3 4 5
    2 3 4 5 6
    3 4 5 6 7
    4 5 6 7 8
  ]
  N = zeros(Int, 5, 5)
  fill!(N,n)
  (x -> x>9 ? x-9 : x).(N + S)
end

function expandedmat(M)
  H = size(M,1)
  W = size(M,2)
  M2 = zeros(Int, H*5, W*5)
  for x in 1:H, y in 1:W
    M2[x:H:end,y:W:end] = expanded_vals(M[x,y])
  end
  M2
end

function cheapestpath(M)
  q = [(0,1,1)]
  costs = Dict()
  while true
    cost,x,y = q[1]
    if x==size(M,1) && y==size(M,2)
      return cost
      break
    end
    popfirst!(q) 
    for (dx,dy) ∈ [(-1,0), (1,0), (0,1), (0,-1)]
      if x+dx in 1:size(M,1) && y+dy in 1:size(M,2)
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
end

function cheapestpath2(M,scalar)
  H = size(M,1)
  W = size(M,2)
  q = [(0,1,1)]
  costs = Dict()
  while true
    cost,x,y = q[1]
    if x==H*scalar && y==W*scalar
      return cost
    end
    popfirst!(q) 
    # val = Msmall[mod(x,size(Msmall,1)),mod(y,size(Msmall,2))] + trunc(Int,x/size(Msmall,1)) + trunc(Int,y/size(Msmall,2))
    @show mod(x,)
    for (dx,dy) ∈ [(-1,0), (1,0), (0,1), (0,-1)]
      if x+dx in 1:H*scalar && y+dy in 1:W*scalar
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
end

M = readinput("inputs/11-15/15ex.txt")
# @show cheapestpath(M)

M2 = expandedmat(M)
# @show cheapestpath2(M2,M)
@show cheapestpath2(M,1)

using BenchmarkTools
# @btime cheapestpath(M)