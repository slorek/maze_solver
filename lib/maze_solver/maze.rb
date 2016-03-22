require 'maze_solver/validations'
require 'maze_solver/exceptions'

module MazeSolver
  class Maze
    include Validations

    def initialize(maze)
      @maze = parse(maze)
      raise InvalidMaze.new unless valid?

      @position  = start_position
      @movements = []
      @solution  = []
      @forks     = []
    end

    def to_s
      output = maze.dup
      solution.each { |pos| output[pos.last][pos.first] = MOVE_IDENTIFIER } if at_end?
      output.map { |row| row.join }.join("\n")
    end

    def start_position
      return @start_position if @start_position

      row = maze.find_index { |row| row.include?(START_IDENTIFIER) }
      column = maze[row].find_index { |column| column == START_IDENTIFIER }

      @start_position = [column, row]
    end

    def solve
      move until at_end?
      solution
    end

    attr_reader :maze, :position, :solution

    private

    attr_reader :forks, :movements

    def parse(maze)
      maze.split("\n").map { |row| row.split(//) }
    end

    def move
      raise UnsolveableMaze unless @position = next_movement

      @forks     << position if fork? && !forks.include?(position)
      @movements << position
      @solution  << position
    end

    def next_movement
      possible_movements.reject { |pos| visited?(pos) }.first || revert_to_last_fork
    end

    def revert_to_last_fork
      forks.delete(position)

      return unless forks.any?

      @solution = solution.slice(0, solution.index(forks.last))
      forks.last
    end

    def possible_movements
      neighbours.select {|pos| [PATH_IDENTIFIER, END_IDENTIFIER].include?(at_position(pos)) }
    end

    def neighbours
      x = position.first
      y = position.last

      [
        [x, y - 1],
        [x, y + 1],
        [x - 1, y],
        [x + 1, y]
      ]
    end

    def visited?(pos)
      movements.include?(pos) || at_position(pos) == START_IDENTIFIER
    end

    def fork?
      possible_movements.size > (at_start? ? 1 : 2)
    end

    def num_rows
      maze.size
    end

    def num_columns
      maze.first.size
    end

    def at_end?
      at_position(position) == END_IDENTIFIER
    end

    def at_start?
      at_position(position) == START_IDENTIFIER
    end

    def at_position(pos)
      (maze[pos.last] || [])[pos.first]
    end
  end
end
