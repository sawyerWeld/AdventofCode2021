nums = map(str -> [parse(Int,str[l]) for l in findall(r"[[:digit:]]+", str)], readlines("inputs/6-10/07.txt"))[1]
using Statistics


function part1(nums)
  med = Statistics.median(nums)
  t = 0
  for n in nums
    t += abs(n-med)
  end
  t
end


sum_to(n) = n*(n+1) / 2

function part2(nums)
  best = typemax(Int)
  for n in minimum(nums):maximum(nums)
    t = 0
    for crab in nums
      t += sum_to(abs(n - crab))
    end
    best = t < best ? t : best
  end
  round(Int, best)
end


function part2faster(nums)
  med = floor(mean(nums) - 0.5)
  t = 0
  for n in nums
    t += sum_to(abs(n-med))
  end
  t
end

day7part2(nums) = map(n->(n->n*(n+1)/2)(n-floor(mean(nums))),nums)|>sum

sum_to(n) = n*(n+1) / 2
