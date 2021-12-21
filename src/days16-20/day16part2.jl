function parse_input(filename)
  hex = readlines(filename)[1]
  base10 = parse.(Int8,collect(hex),base=16)
  base2 = digits.(base10,base=2,pad=4) |> reverse
  Iterators.flatten(base2) |> collect |> reverse
end

to_dec(bit_vec) =  parse(Int,join(bit_vec),base=2)

# pops first n values and returns them
consume!(bits, n) = splice!(bits, 1:n)


t = 0

function parse_packet(bits)
  global t
  version = to_dec(consume!(bits,3))
  t += version
  typeID = to_dec(consume!(bits,3))
  if typeID == 4 # literal packet
    A = []
    while bits[1] == 1
      append!(A, consume!(bits,5)[2:end])
    end
    append!(A, consume!(bits,5)[2:end])
    return to_dec(A)
  else # operator packet
    subvals = []
    ltype = consume!(bits,1)[1]
    if ltype == 0 # next 15 bits are subpacket len
      sublen = to_dec(consume!(bits,15))
      subbits = consume!(bits,sublen)
      while !isempty(subbits)
        push!(subvals, parse_packet(subbits))
      end
    else # next 11 bits are the count of subpackets
      subcount = to_dec(consume!(bits,11))
      for _ in 1:subcount
        push!(subvals, parse_packet(bits))
      end
    end
    if typeID == 0
      return sum(subvals)
    elseif typeID == 1
      return prod(subvals)
    elseif typeID == 2
      return minimum(subvals)
    elseif typeID == 3
      return maximum(subvals)
    elseif typeID == 5
      return subvals[1] > subvals[2] ? 1 : 0
    elseif typeID == 6
      return subvals[1] < subvals[2] ? 1 : 0
    else 
      return subvals[1] == subvals[2] ? 1 : 0
    end
  end
end


bits = parse_input("inputs/16-20/16.txt");
println("Part1: $t")
println("Part2: $(parse_packet2(copy(bits)))")

using BenchmarkTools
@btime parse_packet(copy(bits))
