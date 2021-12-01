nums = [parse(Int64, x) for x in readlines("inputs/01.txt")]
increases = 0
for i in 2:length(nums)
  if nums[i] > nums[i-1]
    increases += 1
  end
end
print(increases)
