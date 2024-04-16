module Outcome
    WIN = :Win
    LOSE = :Lose
    DRAW = :Draw
end

class Judge
    def initialize(moves_count)
      @moves_count = moves_count
    end
  
    def decide(first_move, second_move)
      return Outcome::DRAW if first_move == second_move
  
      if (second_move > first_move && second_move - first_move <= @moves_count / 2) || (second_move < first_move && first_move - second_move > @moves_count / 2)
        return Outcome::WIN
      end
  
      Outcome::LOSE
    end
end