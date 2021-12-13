using DataStructures

function readmatrix(filename)
  lines = readlines(filename)
  nums = [[parse(Int, x) for x in line] for line in lines]
  M = zeros(Int, (length(nums),length(nums[1])))
  for r in 1:length(nums)
    M[r,:] = nums[r]
  end
  M
end

const M = readmatrix("inputs/11-15/11.txt")

neighbors((x,y)) = [(x+i,y+j) for i in -1:1, j in -1:1 if (i,j) != (0,0) && 0 < x+i <= 10 && 0 < y+j <= 10]

function day11(M)
  for s in 1:500
    f = 0
    M.+=1
    S = Stack{Tuple{Int64, Int64}}()
    for i in 1:10, j in 1:10 
      if M[i,j] > 9
        push!(S, (i,j))
      end
    end
    while !isempty(S)
      (i,j) = pop!(S)
      f += 1
      for (ni, nj) in neighbors((i,j))
        M[ni,nj] += 1
        if M[ni,nj] == 10
          push!(S, (ni,nj))
        end
      end
    end
    f == 100 && return s
    M = map(x -> x > 9 ? 0 : x, M)
  end
  return -1
end

using BenchmarkTools

@show day11(M)
@btime day11(M) setup=(M=readmatrix("inputs/11-15/11.txt"))