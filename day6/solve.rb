class Solve
  class << self
    @@input = @@input = File.read("input.txt").split("\n")

    def part_1
      time_raw, distance_raw = @@input
      times = time_raw.split(":").last.split.map(&:to_i)
      distances = distance_raw.split(":").last.split.map(&:to_i)

      parsed_data = times.zip(distances)

      result = []
      parsed_data.each do |time, distance|
        result << solve_for_one(time, distance)
      end

      result.inject(&:*)
    end

    def part_2
      time_raw, distance_raw = @@input
      times = time_raw.split(":").last.split.join.to_i
      distances = distance_raw.split(":").last.split.join.to_i

      solve_for_big_num(times, distances)
    end

    def solve_for_big_num(total_time, distance)
      # Calculate the two points where t * (total_time - t) = distance
      t1 = (total_time - Math.sqrt(total_time**2 - 4 * distance)) / 2
      t2 = (total_time + Math.sqrt(total_time**2 - 4 * distance)) / 2

      # The sum is the difference between the two points, rounded to the nearest integer
      (t2 - t1).round
    end

    def solve_for_one(total_time, distance)
      sum = 0

      (1..total_time).each do |t|
        time_remaining = total_time - t
        res = t * time_remaining

        if res > distance
          sum += 1
        end
      end

      sum
    end
  end
end
p Solve.part_1
p Solve.part_2
