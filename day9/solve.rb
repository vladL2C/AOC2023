class Solve
  @@input = File.read("./input.txt")

  def self.part_1
    data = parsed_data

    data
      .map { |line| get_all_derived_results_for(line) }
      .map(&:last).sum
  end

  def self.part_2
    data = parsed_data

    data
      .map { |line| get_all_derived_results_for(line) }
      .map(&:first).sum
  end

  def self.get_all_derived_results_for(line)
    derived_results = [line]
    current = line

    until current.all?(&:zero?)
      current = derived_line(current)
      derived_results.unshift(current)
    end

    derived_results.each_cons(2) do |prev_item, next_item|
      next_item.unshift(next_item.first - prev_item.first)
      next_item.push(prev_item.last + next_item.last)
    end

    derived_results.last
  end

  def self.derived_line(line)
    line.each_cons(2).map do |a, b|
      b - a
    end
  end

  def self.parsed_data
    @@input.split("\n").map { |s| s.split.map(&:to_i) }
  end
end
