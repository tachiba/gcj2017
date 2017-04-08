class FasterBathroomStalls
  attr_reader :initial_stalls_count, :initial_people_count,
              :last_min, :last_max, :almost_full

  def initialize(stalls_count, people_count)
    @initial_stalls_count = stalls_count.to_i
    @initial_people_count = people_count.to_i

    @spaces_count = @initial_stalls_count
    @stalls = [@spaces_count]
  end

  def call
    return 0, 0 if initial_people_count == initial_stalls_count ||
      initial_people_count > (initial_stalls_count * 2) / 3

    _occupy_all

    return @last_min, @last_max
  end

  private

  def _occupy_all
    index = 0

    @initial_people_count.times do
      s1, s2 = _occupy(@stalls[index])

      @last_max = s1
      @last_min = s2

      @stalls[index] = s1
      @stalls.insert(index + 1, s2)

      # puts @stalls.to_s

      if @last_min == 0 && @last_max == 0
        return
      elsif @stalls.size > index + 2
        index += 2
      else
        index = 0

        _finish_current_depth
      end
    end
  end

  def _occupy(space)
    q, m = (space - 1).divmod(2)
    [q + m, q]
  end

  def _finish_current_depth
    @stalls.sort! { |x, y| y <=> x }

    new_stalls = []
    indexes_same_values = 0
    prev_value = nil
    @stalls.each do |v|
      if prev_value == v
        indexes_same_values += 1
      else
        new_stalls << [prev_value, indexes_same_values]

        prev_value = v
      end
    end
  end
end