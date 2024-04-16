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

user = HumanPlayer.new(player_name)

enemy1 = Player.new('Josiane')
enemy2 = Player.new('José')

enemies = [enemy1, enemy2]

while user.life_points > 0 && enemies.any? { |enemy| enemy.life_points > 0 }
  puts user.show_state
  puts '-----'

  loop do
    puts '-----'
    puts 'Quelle action veux-tu effectuer ?'
    puts 'a - Chercher une meilleure arme'
    puts 's - Chercher à se soigner'
    puts 'Attaquer un joueur en vue :'
    puts '0 - Josiane'
    puts '1 - José'

    enemies.each do |enemy|
      enemy.show_state
    end
    puts user.show_state

    print '> '
    choice = gets.chomp.downcase

    case choice
    when 'a'
      user.search_weapon
    when 's'
      user.search_health_pack
    when '0', '1'
      enemy_index = choice.to_i
      if enemy_index >= 0 && enemy_index < enemies.length
        user.attacks(enemies[enemy_index])
      else
        puts 'Choix invalide. Veuillez sélectionner un ennemi existant.'
      end
    else
      puts 'Choix invalide. Veuillez choisir une option parmi les proposées.'
    end

    puts "Les autres joueurs t'attaquent !"
    break
  end

  break if user.life_points <= 0 || enemies.all? { |enemy| enemy.life_points <= 0 }

  enemies.each do |enemy|
    enemy.attacks(user) if enemy.life_points > 0
  end
end

if user.life_points > 0 && enemies.all? { |enemy| enemy.life_points <= 0 }
puts "----------"
  puts 'Félicitations ! Tu as vaincu tous tes ennemis. Victoire !'
end

puts 'Fin du jeu'
