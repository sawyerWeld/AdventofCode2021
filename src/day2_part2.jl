lines = readlines("inputs/02.txt")
forward = 0
vert = 0
aim = 0
for x in lines
  num = parse(Int64, split(x,' ')[2])
  if x[1] == 'f'
    forward += num
    vert += aim * num
  elseif x[1] == 'd' 
    aim += num
  else
    aim -= num
  end
end
println(forward * vert)
