require 'pry'

class Player
  attr_accessor :name, :life_points

  def initialize(name_to_save)
    @name = name_to_save
    @life_points = 10
  end

  def show_state
    if is_a?(HumanPlayer)
      puts "#{@name} a #{@life_points} points de vie et une arme de niveau #{@weapon_level}"
    else
      puts "#{@name} a #{@life_points} points de vie"
    end
  end

  def attacks(player)
    puts "#{@name} attaque #{player.name}"
    damage = compute_damage
    player.gets_damage(damage)
    puts "Il lui inflige #{damage} points de dommages"
  end

  def gets_damage(number)
    @life_points -= number
    if @life_points <= 0
      puts "#{@name} n'a plus de points de vie, le joueur est mooooort !"
    else
      puts "Il reste à #{@name} #{@life_points} points de vie"
    end
    @life_points
  end
end

class HumanPlayer < Player
  attr_accessor :weapon_level

  def initialize(player_name)
    @name = player_name
    @life_points = 100
    @weapon_level = 1
  end

  def search_weapon
    new_weapon = rand(1..6)
    puts "Tu as trouvé une arme de niveau #{new_weapon}"
    if new_weapon > @weapon_level
      @weapon_level = new_weapon
      puts 'Bien ouej, elle est meilleure que ton arme, prends la'
    else
      puts 'Meh, pas ouf. Garde la tienne'
    end
  end

  def search_health_pack
    chance =  rand(1..6)
    if chance == 1
      puts "Loser ! T'as rien trouvé!"
    elsif chance >= 2 && chance <= 5
      if @life_points + 50 <= 100
        puts 'Bravo, tu as trouvé 50 points de vie !'
        @life_points += 50
      else
        puts 'Tu as déjà trop de points de vie'
      end
    elsif chance == 6
      if @life_points + 80 <= 100
        puts 'Wow, tu as trouvé 80 points de vie !'
        @life_points += 80
      else
        puts 'Tu as déjà trop de points de vie'
      end
    end
    @life_points = 100 if life_points > 100
  end
end
