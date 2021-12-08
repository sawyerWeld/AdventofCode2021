lines = readlines("inputs/02.txt")
forward = 0
vert = 0
for x in lines
  num = parse(Int64, split(x,' ')[2])
  if x[1] == 'f'
    forward += num
  elseif x[1] == 'd' 
    vert += num
  elseif x[1] == 'u'
    vert -= num
  end
end
println(forward * vert)
