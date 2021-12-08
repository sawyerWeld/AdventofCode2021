nums = [parse(Int64, x) for x in readlines("inputs/01.txt")]
increases = 0
for i in 4:length(nums)
  if nums[i] > nums[i-3]
    increases += 1
  end
end
print(increases)
