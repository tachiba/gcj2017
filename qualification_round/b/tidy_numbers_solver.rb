class TidyNumbersSolver
  attr_reader :max, :current, :next_candidate

  def initialize(input)
    @max = input.to_i
    @current = @max
  end

  def call
    loop do
      return @current if _tidy?

      _jump_to_next_candidate
    end
  end

  private

  def _tidy?
    prev_digit = nil

    @current.to_s.each_char.with_index do |digit_str, index|
      digit = digit_str.to_i

      if index == 0
        prev_digit = digit

        next
      end

      if prev_digit > digit
        prev_cursor = index - 1
        zero_length = @current.to_s.size - index

        @next_candidate = (@current.to_s[0..prev_cursor] + '0' * zero_length).to_i

        return false
      end

      prev_digit = digit
    end

    true
  end

  def _jump_to_next_candidate
    if next_candidate
      @current = next_candidate - 1
    else
      @current -= 1
    end
  end
end