# broken code i need to reference 

function p2(lines)
  t = 0 #p1 ans
  scores = [] #p2
  for (i,line) in enumerate(lines)
    cor = false
    Q = Queue{Char}()
    for c in collect(line)
      # println("$c")
      if c ∈ ['(', '[', '{', '<']
        enqueue!(Q, c)
        # @show Q
      elseif c == ')'
        if isempty(Q) || last(Q) != '('
          t += 3
          cor = true
          break
        else
          !isempty(Q) && dequeue!(Q)
        end
      elseif c == ']'
      if isempty(Q) || last(Q) != '['
          t += 57
          cor = true
          break
        else
          !isempty(Q) && dequeue!(Q)
        end
      elseif c == '}'
        if isempty(Q) || last(Q) != '{'
          t += 1197
          cor = true
          break
        else
          !isempty(Q) && dequeue!(Q)
        end
      elseif c == '>'
        if isempty(Q) || last(Q) != '<'
          t += 25137
          cor = true
          break
        else
          !isempty(Q) && dequeue!(Q)
        end
      end
    end
    if !cor 
      score  = 0
      map = Dict('(' => 1, '[' => 2, '{' => 3, '<' => 4)
      while !isempty(Q)
        val = dequeue!(Q)
        score *= 5
        score += map[val]
      end
      push!(scores, score)
    end
  end
  # @show t
end
