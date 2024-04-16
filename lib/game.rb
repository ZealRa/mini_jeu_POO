require 'pry'

def compute_damage
  weapon_level = @weapon_level || 1
  rand(1..6) * weapon_level
end
