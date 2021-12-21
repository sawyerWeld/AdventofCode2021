using DataStructures

function parseinput(file)
  Rules = Dict{String, String}()
  lines = readlines(file)
  for line in lines[3:end]
    sp = split(line, " -> ")
    a, b = String(sp[1]), String(sp[2])
    Rules[a] = b
  end
  Rules, lines[1]
end

function day14(Rules::Dict{String, String}, S::String, steps::Int)
# function day14(Rules, S, steps)
  Pairs = DefaultDict{String, Int}(0)
  for i in 1:length(S)-1
    Pairs[S[i]*S[i+1]] += 1
  end
  for _ in 1:steps
    N = DefaultDict{String, Int}(0)
    for k in keys(Pairs)
      N[k[1]*Rules[k]] += Pairs[k]
      N[Rules[k]*k[2]] += Pairs[k]
    end
    Pairs = N
  end
  chars = DefaultDict{Char,Int}(0)
  for k in keys(Pairs)
    chars[k[1]] += Pairs[k]
  end
  chars[S[end]] += 1
  v = values(chars)
  maximum(v) - minimum(v)
end

Rules, S = parseinput("inputs/11-15/14.txt")
@show day14(Rules, S, 10)
@show day14(Rules, S, 40)

using BenchmarkTools
@btime day14(Rules, S, 40)
