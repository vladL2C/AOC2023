class Solve
  @@input = File.read("input.txt").each_line.map(&:chomp)
  class << self
    def gear_ratios
      gear_ratios = []

      @@input.each_with_index do |line, row_idx|
        line.each_char.with_index do |char, col_idx|
          if char == "*"
            # Check the 8 directions: up, down, left, right, up-left, up-right, down-left, down-right
            directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, -1], [1, 1]]
            adjacent_numbers = []

            directions.each do |dx, dy|
              new_row = row_idx + dx
              new_idx = col_idx + dy

              if new_row >= 0 && new_row < @@input.length && new_idx >= 0 && new_idx < @@input[new_row].length
                if @@input[new_row][new_idx].match?(/\d/)
                  number_start_idx = new_idx
                  number_start_idx -= 1 while number_start_idx > 0 && @@input[new_row][number_start_idx - 1].match?(/\d/)
                  number_end_idx = new_idx
                  number_end_idx += 1 while number_end_idx < @@input[new_row].length - 1 && @@input[new_row][number_end_idx + 1].match?(/\d/)
                  adjacent_numbers << @@input[new_row][number_start_idx..number_end_idx].to_i
                end
              end
            end

            gear_ratios << adjacent_numbers.uniq.reduce(:*) if adjacent_numbers.uniq.size == 2
          end
        end
      end

      gear_ratios
    end

    def part_2
      gear_ratios.sum
    end

    def part_1
      adjacent_numbers.sum
    end

    def adjacent_numbers
      adjacent_numbers = []

      number_coordinates.each do |row, numbers|
        numbers.each do |start_idx, end_idx|
          # Check the 8 directions: up, down, left, right, up-left, up-right, down-left, down-right
          directions = [[-1, 0], [1, 0], [0, -1], [0, 1], [-1, -1], [-1, 1], [1, -1], [1, 1]]
          symbol_found = false
          (start_idx..end_idx).each do |idx|
            directions.each do |dx, dy|
              new_row = row + dx
              new_idx = idx + dy

              if new_row >= 0 && new_row < @@input.length && new_idx >= 0 && new_idx < @@input[new_row].length && !symbol_found
                if !@@input[new_row][new_idx].match?(/\d/)
                  if @@input[new_row][new_idx] != "."
                    adjacent_numbers << @@input[row][start_idx..end_idx].to_i
                    symbol_found = true
                  end
                end
              end
            end
          end
        end
      end

      adjacent_numbers.to_a
    end

    def number_coordinates
      coordinates = {}

      @@input.each_with_index do |line, row_idx|
        start_index = nil
        coordinates[row_idx] = []
        line.each_char.with_index do |char, col_idx|
          if char.match?(/\d/)
            start_index = col_idx if start_index.nil?
            if col_idx == line.length - 1 || !line[col_idx + 1].match?(/\d/)
              coordinates[row_idx] << [start_index, col_idx]
              start_index = nil
            end
          end
        end
      end

      coordinates
    end
  end
end

p Solve.part_2
