lines = readlines("inputs/6-10/08.txt")

t = 0
for line in lines
  lin = split(line, ' ')[end-4:end]
  foo = filter(x -> length(x) ∈ [2,3,4,7], lin )
  t += length(foo)
end
@show t
