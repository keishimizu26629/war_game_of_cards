class Player
  attr_accessor :hand, :added_hand
  attr_reader :name, :num_of_total_hands
  def initialize(name)
      @name = name
      @hand = []
      @added_hand = []
      @num_of_total_hands = 0
  end

  def calculate_total_hands()
      @num_of_total_hands = @hand.length + @added_hand.length
  end
end
