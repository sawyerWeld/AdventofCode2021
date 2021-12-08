nums = map(str -> [parse(Int,str[l]) for l in findall(r"[[:digit:]]+", str)], readlines("inputs/6-10/08.txt"))[1]

lines = readlines("inputs/6-10/08.txt")

t = 0
for line in lines
  lin = split(line, ' ')[end-4:end]
  # lin = filter(x -> x != "|", lin)
  foo = filter(x -> length(x) ∈ [2,3,4,7], lin )
  t += length(foo)
end
