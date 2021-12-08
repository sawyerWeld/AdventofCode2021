start = map(str -> [parse(Int,str[l]) for l in findall(r"[[:digit:]]+", str)], readlines("inputs/6-10/06.txt"))[1].+1

function day6(start, days)
  c = zeros(Int, 9)
  for x in start
    c[x] += 1
  end
  for _ in 1:days
    n = zeros(Int, 9)
    for (age, cnt) in enumerate(c)
      if age == 1
        n[7] += cnt
        n[9] += cnt
      else
        n[age-1] += cnt
      end
    end
    c = n
  end
  sum(c)
end

println("Day 6 Part 1: ",day6(start, 80))
println("Day 6 Part 2: ",day6(start, 256))
