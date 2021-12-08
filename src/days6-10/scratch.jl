using Agents, Agents.Pathfinding

lines = readlines("inputs/misc/maze.txt")

@agent Walker GridAgent{2} begin end

function parse_maze(lines)
  chars = [l |> collect for l in lines]
  charmatrix = hcat(chars...)
  sloc = findfirst(c -> c == 'S', charmatrix)
  gloc = findfirst(c -> c == 'G', charmatrix)
  copy(BitArray(map(x -> x ∈ [' ','G','S'], charmatrix))'), sloc, gloc
end

function main()
  maze, sloc, gloc = parse_maze(lines)
  space = GridSpace(size(maze); periodic = false)
  pathfinder = Agents.Pathfinding.AStar((8,13); walkmap=maze, diagonal_movement=false)
  model = ABM(Walker, space)
  # Place a walker at the start of the maze
  walker = Walker(1, Tuple(sloc))
  add_agent_pos!(walker, model)
  # The walker's movement target is the end of the maze.
  set_target!(walker, Tuple(gloc), pathfinder)

  return model, pathfinder
end

main()
