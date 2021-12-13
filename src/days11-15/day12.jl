using DataStructures
using Graphs
# using Statistics
# using Combinatorics

lines = readlines("inputs/11-15/12ex.txt")
# lines = readlines("inputs/11-15/12.txt")
# nums = map(str -> [parse(Int,str[l]) for l in findall(r"[[:digit:]]+", str)], lines)
# tallNums(lines) = [parse(Int64, x) for x in lines]
# A = zeros(Int, 23, 23)

global m = DefaultDict([])

global isBig = DefaultDict(false)

global caves = ["start","end"]


for line in lines
  (a, b) =  split(line,'-')
  for x in [a,b]
    if x ∉ caves
      push!(caves, x)
    end
    # determine big
    if x ∉ ["start","end"]
      if x == uppercase(x)
        isBig[x] = true
      else
        isBig[x] = false
      end
    end
  push!(m[a],b)
  push!(m[b],a)
  end
end

function cpaths()
  v = DefaultDict(false)
  pathCount = [0]
  cpathsuntil("start",v,pathCount)
  pathCount[1]
end

function cpathsuntil(a,v,pathCount)
  @show a, v, pathCount[1]
  if !isBig[a]
    v[a] = true
  end
  if a == "end"
    pathCount[1] += 1
  else
    for neighbor in m[a]
      if !v[neighbor]
        cpathsuntil(neighbor,v,pathCount)
      end
    end
  end
  v[a] = false
end

cpaths()



adj = DefaultDict([])
for l in lines
  a,b = split(l,'-')
  push!(adj[a], b)
  push!(adj[b], a)
end

small(x) = x != uppercase(x) 

function cp(adj, start, goal, v=DefaultDict(false), twice = false)
  (start == goal) && return 1
  t = 0
  for ne in adj[start]
    
    if small(ne) && v[ne]
      if a in ["start",]
end




