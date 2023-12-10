class Solve
  REGEX_PATTERN = /\D/
  REPLACE_WITH = ""
  VALID_NUMBERS = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

  @@input = File.read("input.txt").split("\n")

  class << self
    def part_1
      @@input
        .map { |txt| txt.gsub(REGEX_PATTERN, REPLACE_WITH) }
        .map { |txt| "#{txt[0]}#{txt[-1]}" }
        .map(&:to_i)
        .sum
    end

    def part_2
      parsed_input
        .map { |txt| txt.gsub(REGEX_PATTERN, REPLACE_WITH) }
        .map { |txt| "#{txt[0]}#{txt[-1]}" }
        .map(&:to_i)
        .sum
    end

    def parsed_input
      result = []
      @@input.each do |line|
        curr_str = ""

        line.chars.each.with_index do |char, i|
          VALID_NUMBERS.each do |number|
            if line[i..i + number.length - 1] == number
              curr_str += (VALID_NUMBERS.index(number) + 1).to_s
            end
          end

          if Integer(char, exception: false)
            curr_str += char
          end
        end

        result << curr_str
      end
      result
    end
  end
end

puts Solve.part_1
puts Solve.part_2
