class TypeOfDeath
  attr_accessor :name, :quantity

  def initialize(name)
    @name = name
    @quantity = 1
  end

  def add_quantity
    @quantity += 1
  end
end