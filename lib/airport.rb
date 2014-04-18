class Airport
  
  DEFAULT_CAPACITY = 10

  def initialize(options = {})
    @capacity = options.fetch(:capacity, capacity)
    planes
  end

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

  def planes
    @planes ||= []
  end

  def full?
    planes.count >= capacity
  end

  def land(plane)
    plane.land!
    planes << plane
  end

  def launch!
    plane = planes.pop
    plane.takeoff!
  end

end