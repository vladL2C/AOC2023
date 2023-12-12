class Solve
  @@input = File.read("input.txt")
  START_NODE = "AAA"
  END_NODE = "Z"
  DIRECTION_L = "L"
  DIRECTION_R = "R"

  def self.part_1
    find(START_NODE, *parsed_data)
  end

  def self.part_2
    ops, nodes = parsed_data
    nodes
      .keys
      .select { |k| k.end_with?(START_NODE.slice(0, 1)) }
      .map { |k| find(k, ops.dup, nodes) }
      .inject(&:lcm)
  end

  def self.find(curr_node, ops, nodes)
    count = 0

    until curr_node.end_with?(END_NODE)
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
p Solve.part_2
