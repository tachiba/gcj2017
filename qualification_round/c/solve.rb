require_relative 'faster_bathroom_stalls'
require 'benchmark'

def solve(index, input)
  n, k = input.split
  min, max = FasterBathroomStalls.new(n, k).call
  "Case ##{index}: #{max} #{min}"
end

b = Benchmark.measure do
  $stdin.each_line.with_index do |line, index|
    next if index == 0 || line.nil? || line.size == 0

    b1 = Benchmark.measure do
      puts line
      puts solve(index, line)
    end

    puts b1
  end
end

puts b
