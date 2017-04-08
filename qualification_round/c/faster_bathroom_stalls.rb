class FasterBathroomStalls
  attr_reader :initial_stalls_count, :initial_people_count,
              :last_min, :last_max, :almost_full

  def initialize(stalls_count, people_count)
    @initial_stalls_count = stalls_count.to_i
    @initial_people_count = people_count.to_i

    @spaces_count = @initial_stalls_count
    @stalls = [[@spaces_count, 1]]
  end

  def call
    return 0, 0 if initial_people_count == initial_stalls_count

    _occupy_all

    return @last_min, @last_max
  end

  private

  def _occupy_all
    stalls_index = 0
    calculated_index = 0

    loop do
      # puts "1: #{@stalls}"

      value = @stalls[stalls_index].first
      count = @stalls[stalls_index].last

      s1, s2 = _occupy(value)

      @last_max = s1
      @last_min = s2

      @stalls[stalls_index] = [s1, count]
      @stalls.insert(stalls_index + 1, [s2, count])

      if @last_min == 0 && @last_max == 0
        return
      elsif @stalls.size > stalls_index + 2
        stalls_index += 2
      else
        stalls_index = 0

        _finish_current_depth
      end

      # puts "2: #{@stalls}"

      calculated_index += count

      return if calculated_index >= initial_people_count
    end
  end

  def _occupy(space)
    q, m = (space - 1).divmod(2)
    [q + m, q]
  end

  def _finish_current_depth
    # puts '#_finish_current_depth'
    # puts "1.5: #{@stalls}"

    saved_count = 0
    @stalls = @stalls.sort{ |x, y| y.first <=> x.first }.map.each_with_index { |a, current_index|
      current_value = a.first
      current_count = a.last
      next_value = @stalls[current_index + 1].first if @stalls.size > current_index + 1

      if next_value && current_value == next_value
        saved_count += current_count

        # puts "#{current_value} #{saved_count}"

        nil
      else
        next_count = saved_count + current_count
        saved_count = 0

        [current_value, next_count]
      end
    }.compact
  end
end