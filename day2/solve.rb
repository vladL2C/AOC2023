class Solve
  @@input = File.read("input.txt").split("\n")

  CONFIG = {red: 12, green: 13, blue: 14}

  class << self
    def calculate_game_cubes(sets)
      game_cubes = {red: 0, green: 0, blue: 0}

      sets.each do |set|
        subset_cubes = {red: 0, green: 0, blue: 0}
        set.split(",").each do |cube|
          count, color = cube.strip.split(" ")
          count = count.to_i
          subset_cubes[color.to_sym] += count
        end
        subset_cubes.each { |color, count| game_cubes[color] = [game_cubes[color], count].max }
      end

      game_cubes
    end

    def part_1
      valid_games = []

      @@input.each do |line|
        game, sets = line.split(":")
        game = game.split(" ").last.to_i
        sets = sets.split(";").map(&:strip)
        game_cubes = calculate_game_cubes(sets)

        all_valid = game_cubes.all? { |color, count| count <= CONFIG[color] }
        valid_games << game if all_valid
      end

      valid_games.sum
    end

    def part_2
      total_power = 0

      @@input.each do |line|
        _, sets = line.split(":")
        sets = sets.split(";").map(&:strip)
        game_cubes = calculate_game_cubes(sets)

        power = game_cubes.values.reduce(:*)
        total_power += power
      end

      total_power
    end
  end
end

p Solve.part_1
p Solve.part_2
