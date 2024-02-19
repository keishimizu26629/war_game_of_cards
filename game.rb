# frozen_string_literal: true

# Gameクラスはゲームの全体の処理に関する内容
class Game
  attr_reader :pool_cards, :compare_cards, :count

  def initialize
    @pool_cards = []
    @compare_cards = []
    @count = 1
  end

  def distribute_cards(cards, players)
    num_of_players = players.length
    max_loop_count = cards.card_collection.length - 1
    (0..max_loop_count).each do |i|
      players[i % num_of_players].hand << cards.card_collection.delete_at(0)
    end
  end

  def match_fixing(cards, players)
    cards.card_collection.each do
      if cards.card_collection[0].strength > 5
        players[0].hand << cards.card_collection.delete_at(0)
      else
        players[1].hand << cards.card_collection.delete_at(0)
      end
    end
  end

  def war(players)
    @count += 1
    players.each do |player|
      put_card(player)
    end

    do_battle(players)
  end

  def sweep_compare_cards
    @pool_cards += @compare_cards
    @compare_cards = []
  end

  def get_cards(winner)
    winner.added_hand += @pool_cards
    @pool_cards = []
  end

  def check_do_rematch(players)
    players.each do |player|
      if player.hand.empty? && player.added_hand.empty?
        return [player, false]
      elsif player.hand.empty?
        player.hand += player.added_hand.shuffle!
        player.added_hand = []
      end
    end
    ['', true]
  end

  private

  def put_card(player)
    # 手札の山札の一番上、要するに配列の一番最後
    puts "#{player.name}のカードは#{player.hand[-1].name}です。"
    @compare_cards << player.hand.delete_at(-1)
  end

  def do_battle(players)
    max_strength = @compare_cards.max_by(&:strength).strength
    size_of_max_strength = @compare_cards.count { |card| card.strength == max_strength }
    joker_index = @compare_cards.find_index { |card| card.mark == 'joker' }

    # 引き分け、かつスペードのAあり（ジョーカーの有無関係なし）
    ace_of_spade_index = @compare_cards.find_index { |card| card.name == 'スペードのA' }
    if size_of_max_strength > 1 && max_strength && !ace_of_spade_index.nil?

      [players[ace_of_spade_index], false]
    # スペードのAなし、かつジョーカーあり
    elsif joker_index
      [players[joker_index], false]

    # 引き分けあり（ジョーカーなし、A有無関係なし）
    elsif size_of_max_strength > 1
      ['', true]

    # 引き分けなし（ジョーカーなし、A有無関係なし）
    else
      [players[@compare_cards.find_index { |card| card.strength == max_strength }], false]
    end
  end
end
