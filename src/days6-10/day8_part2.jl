using Combinatorics
lines = readlines("inputs/6-10/08.txt")

function part1(lines)
  t = 0
  for line in lines
    lin = split(line, ' ')[end-4:end]
    foo = filter(x -> length(x) ∈ [2,3,4,7], lin )
    t += length(foo)
  end
  t
end

str_sort(str) = str |> collect |> sort |> join



# brute force solution that I submitted
function part2slow(lines)
  d = Dict("cf" => 1,
          "acdeg" => 2, 
          "acdfg" => 3, 
          "bcdf" => 4, 
          "abdfg" => 5, 
          "abdefg" => 6, 
          "acf" => 7, 
          "abcdefg" => 8, 
          "abcdfg" => 9, 
          "abcefg" => 0)

  score(new_ans, d) = parse(Int, join([d[join(str_sort(x))] for x in new_ans]))
  
  t = 0
  for line in lines
    wires, ans = split(line, '|')
    wires = split(wires, " ")[1:end-1]
    ans = split(ans, " ")[2:end]
    for perm in permutations("abcdefg" |> collect)
      mapping = Dict(i => j for (i,j) in zip(perm,"abcdefg"))
      new_wires = map(x -> join(mapping[f] for f in x), wires)
      new_ans   = map(x -> join(mapping[f] for f in x), ans)

      if all((join(str_sort(wire))) in keys(d) for wire in new_wires)
        t += score(new_ans, d)
        break
      end
    end
  end
  t
end



score(new_ans, d) = parse(Int, join([d[join(str_sort(x))] for x in new_ans]))


strdiff(a,b) = setdiff(Set(a), Set(b)) |> collect

num_in(char, str) = count(x -> x == char, collect(str))

d = Dict("cf" => 1,
          "acdeg" => 2, 
          "acdfg" => 3, 
          "bcdf" => 4, 
          "abdfg" => 5, 
          "abdefg" => 6, 
          "acf" => 7, 
          "abcdefg" => 8, 
          "abcdfg" => 9, 
          "abcefg" => 0)

function solve_line(line)
  alphabet = "abcdefg"
  s = split(line, ' ')
  wires = s[1:end-5]
  ans = s[end-3:end]
  nums = Dict()
  segs = Dict()
  charcounts = Dict()
  nums[1] = wires[findfirst(x -> length(x) == 2, wires)] 
  nums[7] = wires[findfirst(x -> length(x) == 3, wires)] 
  nums[4] = wires[findfirst(x -> length(x) == 4, wires)] 
  nums[8] = wires[findfirst(x -> length(x) == 7, wires)] 
  segs['a'] = strdiff(nums[7] , nums[1])[1]
  activated_wires = join(wires) |> str_sort
  for char in collect(alphabet)
    charcounts[char] = num_in(char, activated_wires) 
    activations = num_in(char, activated_wires) 
    if activations == 6
      segs['b'] = char
    elseif activations == 9
      segs['f'] = char
    elseif activations == 4
      segs['e'] = char
    elseif activations == 8 && char != segs['a']
      segs['c'] = char
    end
  end
  segs['d'] = strdiff(nums[4], join(values(segs)))[1]
  segs['g'] = strdiff(alphabet, join(values(segs)))[1]

  rev = Dict(value => key for (key, value) in segs)
  parse(Int, [d[x] for x in map(an -> [rev[x] for x in an] |> join |> str_sort, ans)] |> join)
end

function part2(lines)
  t = 0
  for line in lines
    t += solve_line(line)
  end
  t
end

@show part1(lines)
@show part2(lines)
