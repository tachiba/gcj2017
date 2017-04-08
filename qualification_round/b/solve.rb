require_relative 'tidy_numbers_solver'

def solve(index, input)
  output = TidyNumbersSolver.new(input).call
  "Case ##{index}: #{output}"
end

$stdin.each_line.with_index do |line, index|
  next if index == 0 || line.nil? || line.size == 0

  puts solve(index, line)
end
