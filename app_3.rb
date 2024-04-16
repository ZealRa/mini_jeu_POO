require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

puts '-----------------------------------------'
puts '|Bienvenue, mortel. Survis si tu le peux.|'
puts '-----------------------------------------'

puts 'Donne moi ton nom :'
print '> '
player_name = gets.chomp

my_game = Game.new(player_name)

while my_game.is_still_ongoing?
  puts my_game.show_players
  puts "-----"
  my_game.menu
  puts"-----"
  print "> "
  choice = gets.chomp.downcase
  my_game.menu_choice(choice)
  puts "-----"
  my_game.enemies_attack
end

my_game.end_game