class Airport

  attr_reader :planes

  def initialize(capacity=10)
    @capacity = capacity
    @planes = []
  end

  def land!(plane)
    @planes << plane
  end

  def launch!(plane)
    @planes.pop
  end

  def full?
    @planes.count == @capacity
  end

end