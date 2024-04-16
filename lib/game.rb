require 'pry'

def show_state
  puts "#{@name} a #{@life_points} points de vie"
end

def gets_damage(number)
  @life_points -= number
  if @life_points <= 0
    puts "#{@name} n'a plus de points de vie, le joueur est mooooort !"
  else
    puts "Il reste à #{@name} #{@life_points} points de vie"
  end
  return @life_points
end

def attacks(player)
  puts "#{@name} attaque  #{player.name}"
  damage = compute_damage
  player.gets_damage(damage)
  puts "Il lui inflige #{damage} points de dommages"
end
  

def compute_damage
  return rand(1..6)
end