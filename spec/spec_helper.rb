$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'maze_solver'
require 'pry'

def fixture_path
  File.expand_path('../fixtures', __FILE__)
end

def fixture(file)
  File.read(File.join(fixture_path, file))
end
