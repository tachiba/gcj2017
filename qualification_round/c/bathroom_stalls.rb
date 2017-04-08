class BathroomStalls
  attr_reader :stalls_count, :people_count, :last_min, :last_max

  def initialize(stalls_count, people_count)
    @stalls_count = stalls_count.to_i
    @people_count = people_count.to_i
    @stalls = Array.new(@stalls_count) { false }
    @stalls.unshift true
    @stalls.push true
  end

  def call
    @people_count.times { _occupy }

    return @last_min, @last_max
  end

  private

  def _occupy
    candidate_index = nil
    candidate_min = nil
    candidate_max = nil

    @stalls.each_with_index do |v, i|
      next if v

      # puts @stalls.to_s

      l = _left_space_from(i)
      r = _right_space_from(i)

      if candidate_index.nil? ||
          [l, r].min > candidate_min || [l, r].min == candidate_min && [l, r].max > candidate_max
        candidate_index = i
        candidate_min = [l, r].min
        candidate_max = [l, r].max
      end

      # puts "i=#{i} l=#{l} r=#{r} min=#{candidate_min} max=#{candidate_max}"
    end

    @stalls[candidate_index] = true
    @last_min = candidate_min
    @last_max = candidate_max
  end

  def _left_space_from(index)
    (index - 1).downto(0).each do |i|
      if @stalls[i]
        return index - i - 1
      end
    end
  end

  def _right_space_from(index)
    (index + 1).upto(@stalls.size).each do |i|
      if @stalls[i]
        return i - index - 1
      end
    end
  end
end