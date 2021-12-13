using Statistics
using DataStructures

function p1(lines)
  match = Dict('('=>')','['=>']','{'=>'}','<'=>'>')
  scores = Dict(')'=>3, ']'=>57, '}'=>1197, '>'=>25137)
  t = 0
  for line in lines
    Stack = []
    for c in line
      if c ∈ keys(match)
        push!(Stack, c)
      else
        last = pop!(Stack)
        if match[last] != c
          t += scores[c]
          break
        end
      end
    end
  end
  t
end


function p2(lines)
  match = Dict('('=>')','['=>']','{'=>'}','<'=>'>')
  score = Dict('('=>1, '['=>2, '{'=>3, '<'=>4)
  scores = []
  for line in lines
    corrupt = false
    stack = []
    for c in line
      if c ∈ keys(match)
        push!(stack, c)
      elseif match[pop!(stack)] != c
        corrupt = true
        break
      end
    end
    push!(scores, foldl((x,y) -> 5x+score[y], stack, init=0))
  end
  trunc(Int,median(scores))
end

const match = Dict('('=>')','['=>']','{'=>'}','<'=>'>')
const score = Dict('('=>1, '['=>2, '{'=>3, '<'=>4)

function p2helper(line::String)
  corrupt = false
  stack = Stack{Char}()
  for c in line
    if c ∈ keys(match)
      push!(stack, c)
    elseif match[pop!(stack)] != c
      corrupt = true
      break
    end
  end
  s = -1
  if !corrupt
    s = 0
    for x in stack
      s = 5s + score[x]
    end
  end
  s
end

# best speed singlethread
function p2fast(lines::Vector{String})
  scores = Int64[]
  for line in lines
    s = p2helper(line)
    s != -1 && push!(scores, s)
  end
  sort(scores)[trunc(Int,length(lines)/2)]
end

# best speed multithread; works best at nthreads = 3 on my machine
function p2fastMulti(lines::Vector{String})
  scores = Int64[]
  lk = ReentrantLock()
  Threads.@threads for line in lines
    s = p2helper(line)
    s != -1 && lock(lk) do
      push!(scores, s)
    end
  end
  sort(scores)[trunc(Int,length(lines)/2)]
end


using BenchmarkTools



lines = readlines("inputs/6-10/10.txt")

@btime p2fastMulti(lines)

