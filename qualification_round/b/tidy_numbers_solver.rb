class TidyNumbersSolver
  attr_reader :max, :current

  def initialize(input)
    @max = input.to_i
    @current = @max
  end

  def call
    loop do
      return @current if _tidy?

      @current -= 1
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

      return false if prev_digit > digit

      prev_digit = digit
    end

    true
  end
end