# Maze Solver

This Ruby gem library provides instructions and diagrams to solve a maze, which is supplied as a text diagram String.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'maze_solver'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install maze_solver

## Usage

Mazes must be supplied as a String diagram.

Walls and paths are denoted by characters `#` and ` ` respectively. The start position is `S` and end position is marked `E`.

Current start and end must be on a wall boundary, and the maze diagram must be rectangular and fully bounded by walls.

There are various examples of valid and invalid maze diagrams in `spec/fixtures`.

### Example

```ruby
diagram = <<EOF
#S###############
# #   # #   #   #
#   # # # ### # #
##### # # #   # #
#     #     ### #
# ##### # ###   #
#       # ### ###
#############E###
EOF

require 'maze_solver'

maze = MazeSolver::Maze.new(diagram)

maze.solve
```

The solution is supplied as a series of co-ordinates (hoizontal X, vertical Y) in the order of movement.

To display the solution is a diagram, use:

```ruby
maze.solve
puts maze.to_s
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

The `fixture` method is available in order to load test fixtures provided in `spec/fixtures`. For example:

```ruby
$ bin/console
> maze = MazeSolver::Maze.new(fixture('valid_2.maze'))
=> #<MazeSolver::Maze:0x007f96651a0268>
> maze.solve
...
> puts maze.to_s
#################
# #####xxx#xxx#xx
#   ###x#xxx#x#x#
### #xxx# # #xxx#
#xxxxx# # # # # #
Sx# #   # #   # #
#################
```
