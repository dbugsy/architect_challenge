require_relative './weatherconditions'
class Airport

  include WeatherConditions

  attr_reader :planes

  def initialize(capacity=10)
    @capacity = capacity
    @planes = []
  end

  def land!(plane)
    raise 'Airport full! Please try again later.' if full?
    plane.land!
    @planes << plane
  end

  def takeoff!(plane)
    raise 'Stormy weather - runway closed!' if stormy?
    plane.takeoff!
    @planes.delete(plane)
  end

  def full?
    @planes.count == @capacity
  end

end
