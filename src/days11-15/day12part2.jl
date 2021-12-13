using DataStructures
lines = readlines("inputs/11-15/12.txt")

function edges(lines)
  e = DefaultDict(() -> String[])
  for l in lines
    a,b = split(l,'-')
    push!(e[a], b)
    push!(e[b], a)
  end
  e
end

small(x) = x != uppercase(x) 

function cp(adj, start, goal, v=Set([]), twice_ = false)
  (start == goal) && return 1
  t = 0
  @show start, goal
  for ne in adj[start]
    twice = twice_
    if small(ne) && ne ∈ v
      if twice || ne ∈ ["start","end"]
        continue
      else
        twice = true
      end
    end
    push!(v, start)
    t += cp(adj, ne, goal, v, twice)
  end
  t
end


function day12()
  A = edges(lines)
  cp(A, "start", "end", Set([]), false)
end