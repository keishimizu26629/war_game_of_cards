require_relative 'game'
require_relative 'player'
require_relative 'card'
require_relative 'cards'

participants = []

is_draw = false
is_rematch = true

puts '戦争を開始します。'

while true
  print 'プレイヤーの人数を入力してください（2〜5）: '

  num_of_players = gets.to_i
  break if num_of_players >= 2 && num_of_players <= 5

  puts '人数は2~5で再度入力してください。'
end

(1..num_of_players).each do |i|
  print "プレイヤー#{i}の名前を入力してください: "
  participants << gets.chomp
end

cards = Cards.new
players = participants.map do |participant|
  Player.new(participant)
end

game = Game.new
game.distribute_cards(cards, players)
# game.match_fixing(cards, players)

puts 'カードが配られました。'

while true
  break unless is_rematch

  puts "戦争！(#{game.count}回目)"
  winner, is_draw = game.war(players)
  game.sweep_compare_cards
  if is_draw
    puts '引き分けです。'
  else
    puts "#{winner.name}が勝ちました。#{winner.name}はカードを#{game.pool_cards.length}枚もらいました。"
    game.get_cards(winner)
  end
  game_loser, is_rematch = game.check_do_rematch(players)
end

puts "#{game_loser.name}の手札がなくなりました。"

players.each do |player|
  player.calculate_total_hands
  print "#{player.name}の手札の枚数は#{player.num_of_total_hands}枚です。"
end

print "\n"

players.sort_by(&:num_of_total_hands).reverse.each_with_index do |player, index|
  print "#{player.name}が#{index + 1}位"
  if index != players.size - 1
    print '、'
  else
    print "です。\n"
  end
end

puts '戦争を終了します。'
