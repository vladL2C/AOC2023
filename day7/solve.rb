class Hand
  attr_reader :cards, :bid
  def initialize(cards, bid)
    @cards = cards
    @bid = bid
  end
end

class Solve
  @@input = File.read("input.txt").split("\n")

  HAND_TYPES = {
    [5] => ["five of a kind", 7],
    [4, 1] => ["four of a kind", 6],
    [3, 2] => ["full house", 5],
    [3, 1, 1] => ["three of a kind", 4],
    [2, 2, 1] => ["two pair", 3],
    [2, 1, 1, 1] => ["one pair", 2],
    [1, 1, 1, 1, 1] => ["high card", 1]
  }

  JOKER = "J"

  CARD_RANKS = {"2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8, "9" => 9, "T" => 10, "J" => 1, "Q" => 12, "K" => 13, "A" => 14}

  def self.part_2
    sort_cards(parsed_hands)
      .each_with_index
      .reduce(0) { |acc, (hand, i)| acc + (hand.bid * (i + 1)) }
  end

  def self.parsed_hands
    @@input.map do |line|
      cards, val = line.split(" ")
      Hand.new(cards, val.to_i)
    end
  end

  def self.permute_jokers(hand, joker_count)
    CARD_RANKS.keys.reject { |key| key == JOKER }.map do |val|
      new_hand = hand.cards.tr(JOKER, val)
      new_tally = new_hand.chars.tally
      new_tally.values.sort.reverse
    end
      .max
  end

  def self.sort_cards(hands)
    hands.sort_by do |hand|
      tally = hand.cards.chars.tally
      joker_count = tally[JOKER] || 0

      counts = if joker_count > 0
        permute_jokers(hand, joker_count)
      else
        tally.values.sort.reverse
      end

      _, hand_rank = HAND_TYPES[counts]

      card_ranks = hand.cards.chars.map { |c| CARD_RANKS[c] }

      [hand_rank, card_ranks]
    end
  end
end

p Solve.part_2
