require_relative 'faster_bathroom_stalls'
require 'benchmark'

def solve(index, input)
  n, k = input.split
  min, max = FasterBathroomStalls.new(n, k).call
  "Case ##{index}: #{max} #{min}"
end

$stdin.each_line.with_index do |line, index|
  next if index == 0 || line.nil? || line.size == 0

  # puts line
  puts solve(index, line)
end
