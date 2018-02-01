class Recipe
  attr_reader :name
  attr_accessor :description, :cooking_time

  def initialize(name, description, cooking_time)
    @name = name
    @description = description
    @cooking_time = cooking_time
    @tested = false
  end

  def tested?
    return @tested
  end

  def mark_as_tested
    @tested = true
  end
end
