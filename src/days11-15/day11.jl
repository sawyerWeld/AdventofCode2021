# using DataStructures
# using Graphs
# using Statistics
# using Combinatorics

# lines = readlines("inputs/11-15/11ex.txt")
lines = readlines("inputs/11-15/11.txt")
nums = [[parse(Int, x) for x in line] for line in lines]

# 2D list
getat = function(x,y, M, default=-1)
  h = length(M)
  w = length(M[1])
  if x < 1 || y < 1 || x > h || y > w
    return default
  end
  return M[x][y]
end

incv! = function(x,y, M)
  h = length(M)
  w = length(M[1])
  if x < 1 || y < 1 || x > h || y > w
    return M
  end
  M[x][y] += 1
  return M
end

setat! = function(x,y,M,b)
  h = length(M)
  w = length(M[1])
  if x < 1 || y < 1 || x > h || y > w
    return M
  end
  M[x][y] = b
  return M
end


function day11()
  t = 0
  p2 = 0
  for step in 1:500
    # inc all by 1
    for r in 1:10
      for c in 1:10
        nums[r][c] += 1
      end
    end
    flashed = [[false for _ in 1:10] for _ in 1:10]
    for _ in 1:100
      for r in 1:10
        for c in 1:10
          if getat(r,c,nums) > 9
            for dr in [-1,0,1], dc in [-1,0,1]
              incv!(r+dr,c+dc,nums)
            end
            t += 1
            setat!(r,c,flashed,true)
          end
        end
      end
      
      for r in 1:10
        for c in 1:10
          if flashed[r][c]
            nums[r][c] = 0
          end
        end
      end
    end
    allf = true
    for r in 1:10
      for c in 1:10
        if !flashed[r][c]
          allf = false
        end
      end
    end
    if allf
      p2 = step
      return step
      break
    end
  end
end




function octopus_step!(model)
  # increase agent energys
  for agent in allagents(model)
    agent.energy += 1
  end
  while true
    update = false
    for agent in allagents(model)
      if !agent.flashed && agent.energy > 9
        update = true
        agent.flashed = true
        for neighbor in nearby_agents(agent, model)
          neighbor.energy += 1
        end
      end
    end
    for agent in allagents(model)
      agent.flashed = false
    end
    if !update 
      break
    end
  end
  for agent in allagents(model)
    if agent.flashed 
      agent.flashed = false
      agent.energy = 0 
    end
  end
end