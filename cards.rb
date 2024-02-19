# frozen_string_literal: true

# Cardsクラスはカード全体に関する処理
class Cards
  attr_accessor :card_collection

  # MARKS = ['ハート', 'ダイヤ', 'クラブ', 'スペード', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  MARKS = %w[ハート ダイヤ クラブ スペード].freeze
  # RANKS = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  # RANKS = ['K', 'A', 'A']
  STRENGTHS = (1..13).to_a
  # STRENGTHS = [12, 13, 13]
  def initialize
    @card_collection = []
    set_card_collection
    set_joker
    @card_collection.shuffle!
  end

  def set_card_collection
    MARKS.each do |mark|
      RANKS.each_with_index do |rank, index|
        @card_collection << Card.new(mark, rank, STRENGTHS[index], "#{mark}の#{rank}")
      end
    end
  end

  def set_joker
    @card_collection << Card.new('joker', 'joker', 0, 'ジョーカー')
  end
end
