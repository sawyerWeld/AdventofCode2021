

## this was my original day13 main, unfortunately overwrote splitX and Y


function day13()
  lines = readlines("inputs/11-15/13.txt")
  nums = map(str -> [parse(Int,str[l]) for l in findall(r"[[:digit:]]+", str)], lines)
  S = Set(nums)

  S = splitX(S, 655)
  S = splitY(S, 447)
  S = splitX(S, 327)
  S = splitY(S, 223)
  S = splitX(S, 163)
  S = splitY(S, 111)
  S = splitX(S, 81)
  S = splitY(S, 55)
  S = splitX(S, 40)
  S = splitY(S, 27)
  S = splitX(S, 13)
  S = splitY(S, 6)
  @show length(S)
end

