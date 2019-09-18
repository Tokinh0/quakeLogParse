class Player
  attr_accessor :name, :qtd_kills

  def initialize(name)
    @name = name
    @qtd_kills = 0
  end

  def add_kill
    @qtd_kills += 1
  end

  def remove_kill
    @qtd_kills -= 1
  end

end