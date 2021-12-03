lines = readlines("inputs/03.txt")
nums = [[parse(Int64, l) for l in line] for line in lines]
all_digits = [0,0,0,0,0,0,0,0,0,0,0,0]
cur_dig = 1
for digit in 1:12
  sum = 0
  for digits in nums
    sum += digits[digit]
  end
  signal = (sum/length(nums)) >= .5 ? 1 : 0
  if sum/length(nums) == .5
    signal = 1
  end

  filter!(x -> x[digit]==signal,nums)

  if length(nums) == 1
    for x in nums[1]
      print(x)
    end
    println()
  end
end


lines = readlines("inputs/03.txt")
nums = [[parse(Int64, l) for l in line] for line in lines]
all_digits = [0,0,0,0,0,0,0,0,0,0,0,0]
cur_dig = 1
for digit in 1:12
  sum = 0
  for digits in nums
    sum += digits[digit]
  end
  signal = (sum/length(nums)) >= .5 ? 0 : 1
  if sum/length(nums) == .5
    signal = 0
  end

  filter!(x -> x[digit]==signal,nums)

  if length(nums) == 1
    for x in nums[1]
      print(x)
    end
    println()
  end
end