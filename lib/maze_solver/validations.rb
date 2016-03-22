module MazeSolver
  module Validations
    def valid?
      valid_characters? && rows_same_length? && one_start_position? && one_end_position? && bounded?
    end

    private

    def valid_characters?
      maze.flatten.uniq.sort == [PATH_IDENTIFIER, WALL_IDENTIFIER, START_IDENTIFIER, END_IDENTIFIER].sort
    end

    def rows_same_length?
      maze.map { |row| row.size }.uniq.length == 1
    end

    def one_start_position?
      maze.flatten.count { |pos| pos == START_IDENTIFIER } == 1
    end

    def one_end_position?
      maze.flatten.count { |pos| pos == END_IDENTIFIER } == 1
    end

    def bounded?
      bounds.uniq.sort == [WALL_IDENTIFIER, START_IDENTIFIER, END_IDENTIFIER].sort
    end

    def bounds
      (maze.first + maze.last + maze.map { |row| [row.first, row.last] }.flatten)
    end
  end
end
