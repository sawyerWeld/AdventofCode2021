nums = [[parse(Int64, l) for l in line] for line in readlines("inputs/03.txt")]

function day3(nums)
  nums_backup = copy(nums)
  oxygen_vec = 0
  for digit in 1:12
    Σ = sum(map(x -> x[digit], nums) / length(nums))
    signal = Σ >= 0.5 ? 1 : 0
    signal = Σ/length(nums) == .5 ? 1 : signal

    filter!(x -> x[digit]==signal,nums)

    if length(nums) == 1
      oxygen_vec = nums[1]
      break
    end
  end

  nums = nums_backup
  co2_vec = 0
  for digit in 1:12
    Σ = sum(map(x -> x[digit], nums) / length(nums))
    signal = Σ >= 0.5 ? 0 : 1
    signal = Σ/length(nums) == .5 ? 0 : signal
    
    filter!(x -> x[digit]==signal,nums)

    if length(nums) == 1
      co2_vec = nums[1]
      break
    end
  end

  return parse(Int64,join(oxygen_vec),base=2) * parse(Int64,join(co2_vec),base=2)
end

println(day3(nums))
