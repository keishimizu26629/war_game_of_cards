class Card
  attr_reader :name, :mark, :rank, :strength
  def initialize(mark, rank, strength, name)
    @name = name
    @mark = mark
    @rank = rank
    @strength = strength
  end
end
