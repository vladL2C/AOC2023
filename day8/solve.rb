class Solve
  @@input = File.read("input.txt")
  START_NODE = "AAA"
  END_NODE = "ZZZ"
  DIRECTION_L = "L"
  DIRECTION_R = "R"

  def self.part_1
    ops, nodes = parsed_data

    curr_node = START_NODE
    count = 0

    while curr_node != END_NODE
      direction = ops.shift

      if direction == DIRECTION_L
        curr_node, _ = nodes[curr_node]
      end

      if direction == DIRECTION_R
        _, curr_node = nodes[curr_node]
      end

      ops.push(direction)
      count += 1
    end

    count
  end

  def self.parsed_data
    ops_raw, nodes_raw = @@input.split("\n\n")
    ops = ops_raw.chars

    nodes = nodes_raw.split("\n").map do |raw_node|
      node, rest = raw_node.split("=")
      left_node, right_node = rest.gsub(/\s+/, "").delete("(").delete(")").split(",")
      [node.strip, [left_node, right_node]]
    end.to_h

    [ops, nodes]
  end
end

p Solve.part_1
