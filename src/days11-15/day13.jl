using DataStructures

ex = "inputs/11-15/13ex.txt"
function parseinput(file)
  lines = readlines(file)
  b = findall(x->x=="", lines)[1]
  nums = map(str -> Tuple(parse(Int,str[l]) for l in findall(r"[[:digit:]]+", str)), lines[1:b-1])
  fs = []
  for (i,l) in enumerate(lines[b+1:end])
    val = parse(Int,String(split(l,'=')[end]))
    d,val = split(l,'=')[end-1][end], parse(Int,String(split(l,'=')[end]))
    push!(fs, (val, d=='y' ? :y : :x))
  end
  (Set(nums), fs)
end

dist(v, split) = 2split - v

function fold(S, loc, axis=:x)
  for (x,y) in S
    if axis == :x && x > loc
      push!(S,(dist(x,loc),y))
      delete!(S,(x,y))
    elseif axis == :y && y > loc
      push!(S,(x,dist(y,loc)))
      delete!(S,(x,y))
    end
  end
  S
end

function display(G; xline=-1, yline=-1)
  w = maximum(i[1] for i in G) + 1
  h = maximum(i[2] for i in G) + 1
  p = [[' ' for _ in 1:w] for _ in 1:h]
  for (x,y) in G
    p[y+1][x+1] = '#'
  end
  if xline != -1
    p[xline+1] = ['-' for _ in 1:w]
  end
  for l in p
    println(join(l))
  end
end


function day13(S::Set{Tuple{Int64, Int64}}, instructions)
  for (val, axis) in instructions
    S = fold(S, val, axis)
  end
  S
end

main() = display(day13(parseinput("inputs/11-15/13v2.txt")...))

using BenchmarkTools

nums, instructions = parseinput("inputs/11-15/13v2.txt")
@btime day13(nums, instructions)

main()
