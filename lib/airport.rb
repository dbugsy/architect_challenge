require_relative './weather'

class Airport
  include WeatherConditions
  
  DEFAULT_CAPACITY = 10

  attr_writer :planes

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

  def park(plane)
    return 'Please land before you try and park. Dumbass.' if plane.flying_status == :flying
    plane.permission_to_land=(false)
    planes << plane
  end

  def launch!
    return 'Stormy weather: Runway closed!' if self.weather_check == :stormy
    plane = @planes.pop
    plane.takeoff!
  end

  def check_permission_to_land(plane)
    return 'Stormy weather: Runway closed!' if self.weather_check == :stormy
    return 'Permission Denied: Airport Full!' if full?
    plane.permission_to_land=(true)
  end
  

end