require 'spec_helper'

describe MazeSolver::Maze do
  let(:maze) { fixture('valid_1.maze') }
  subject { described_class.new(maze) }

  describe '#initialize' do
    context 'with a valid maze' do
      it 'returns an instance' do
        expect(subject).to be_a described_class
      end

      it 'sets the current position to the start position of the maze' do
        expect(subject.position).to eq([1,0])
        expect(subject.solution).to be_empty
      end
    end

    context 'with an invalid maze' do
      context 'where there are illegal characters' do
        let(:maze) { fixture('invalid_characters.maze') }

        it 'raises MazeSolver::InvalidMaze' do
          expect(->{ subject }).to raise_error(MazeSolver::InvalidMaze)
        end
      end

      context 'where not all rows are the same length' do
        let(:maze) { fixture('invalid_length.maze') }

        it 'raises MazeSolver::InvalidMaze' do
          expect(->{ subject }).to raise_error(MazeSolver::InvalidMaze)
        end
      end

      context 'where there is no end position' do
        let(:maze) { fixture('invalid_no_end.maze') }

        it 'raises MazeSolver::InvalidMaze' do
          expect(->{ subject }).to raise_error(MazeSolver::InvalidMaze)
        end
      end

      context 'where there is no start position' do
        let(:maze) { fixture('invalid_no_start.maze') }

        it 'raises MazeSolver::InvalidMaze' do
          expect(->{ subject }).to raise_error(MazeSolver::InvalidMaze)
        end
      end

      context 'where the maze is not bound by walls' do
        let(:maze) { fixture('invalid_not_bound.maze') }

        it 'raises MazeSolver::InvalidMaze' do
          expect(->{ subject }).to raise_error(MazeSolver::InvalidMaze)
        end
      end
    end
  end

  describe '#start_position' do
    it 'returns the co-ordinates of the starting position of the maze' do
      expect(subject.start_position).to eq([1,0])
    end
  end

  describe '#to_s' do
    context 'when solved' do
      let(:maze_solution) { fixture('valid_1.maze_solution') }

      it 'returns the String representation of the maze and the solution' do
        subject.solve
        expect(subject.to_s).to eq(maze_solution.strip)
      end
    end

    context 'when unsolved' do
      it 'returns the String representation of the maze' do
        expect(subject.to_s).to eq(maze.strip)
      end
    end
  end

  describe '#solve' do
    context 'with a valid maze' do
      let(:solution) do
        [
          [1, 1],
          [1, 2],
          [2, 2],
          [3, 2],
          [3, 1],
          [4, 1],
          [5, 1],
          [5, 2],
          [5, 3],
          [5, 4],
          [4, 4],
          [3, 4],
          [2, 4],
          [1, 4],
          [1, 5],
          [1, 6],
          [2, 6],
          [3, 6],
          [4, 6],
          [5, 6],
          [6, 6],
          [7, 6],
          [7, 5],
          [7, 4],
          [8, 4],
          [9, 4],
          [10, 4],
          [11, 4],
          [11, 3],
          [12, 3],
          [13, 3],
          [13, 2],
          [13, 1],
          [14, 1],
          [15, 1],
          [15, 2],
          [15, 3],
          [15, 4],
          [15, 5],
          [14, 5],
          [13, 5],
          [13, 6],
          [13, 7]
        ]
      end

      it 'returns the solution with no backtracking' do
        expect(subject.solve).to eq(solution)
      end
    end

    context 'with an unsolveable maze' do
      let(:maze) { fixture('invalid_unsolveable.maze') }

      it 'raises UnsolveableMaze' do
        expect(->{ subject.solve }).to raise_error(MazeSolver::UnsolveableMaze)
      end
    end
  end
end
