lines = readlines("inputs/03.txt")
all_digits = [0,0,0,0,0,0,0,0,0,0,0,0]
for x in lines
  digits = [parse(Int64, l) for l in x]
  for d in 1:12
    all_digits[d] += digits[d]
  end
end
norm = [x/1000 for x in all_digits]

bits  = [x >= .5 ? 1 : 0 for x in norm]
bits2 = [x < .5 ? 1 : 0 for x in norm]

for b in bits
  print(b)
end

for b in bits2
  print(b)
end