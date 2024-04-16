require 'pry'


class Game
  attr_accessor :human_player, :enemies

  def initialize(human_name)
    @human_player = HumanPlayer .new(human_name)
    @enemies = []
    4.times { @enemies << Player.new("Enemy#{rand(100)}")}
  end

  def kill_player(player)
    @enemies.delete(player)    
  end

  def is_still_ongoing?
    @human_player.life_points > 0 && !@enemies.empty?
  end

  def show_players
    puts "Voici l'état du joueur :"
    @human_player.show_state
    puts "Il reste #{enemies.length} adversaires."
  end
    
  def menu
    puts "-----"
    puts "Quelle action veux-tu effectuer ?"
    puts "a - Chercher une meilleure arme"
    puts "s - Chercher à se soigner"
    puts "Attaquer un joueur en vue :"
    
    @enemies.each_with_index do |enemy, index|
      if enemy.life_points > 0
        puts "#{index} - #{enemy.name} a #{enemy.life_points} points de vie"
      end
    end
  end

  def menu_choice(choice)
    case choice
    when "a"
      @human_player.search_weapon
    when "s"
      @human_player.search_health_pack
    when /\d+/
      index = choice.to_i
      if index >= 0 && index < @enemies.length && @enemies[index].life_points > 0
        @human_player.attacks(@enemies[index])
        kill_player(@enemies[index]) if @enemies[index].life_points <= 0
      else
        puts "Choix invalide. Veuillez sélectionner un ennemi existant."
      end
    else
      puts "Choix invalide. Veuillez choisir une option parmi les proposées."
    end
  end

  def enemies_attack
    @enemies.each do |enemy|
      enemy.attacks(@human_player) if enemy.life_points > 0 && @human_player.life_points > 0
    end
  end

  def end_game
    puts "Le jeu est fini !"
    if @human_player.life_points > 0
      puts "Bravo ! Tu as vaincu tous tes ennemis. Victoire !"
    else
      puts "HA HA HA CHEH !"
    end
  end

end
