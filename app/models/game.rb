class Game
  attr_accessor :id, :total_kills, :players, :types_of_death

  def initialize(id)
    @id = id
    @total_kills = 0
    @players = []
    @types_of_death = []
  end

  def increment_kill
    @total_kills += 1
  end

end