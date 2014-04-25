require_relative './airport'
require_relative './plane'

# the weather may be changeable, but this method will create environment 
  # where a plane will keep trying until it gets through the storm
  def navigate_storm(plane,airport)
    until plane.instance_variable_get(:@permission_to_land)
      plane.request_permission_to_land_at(airport)
    end
  end

  # method to create environment where planes negotiate a storm and land
  def landing_sequence(plane,airport)
    navigate_storm(plane, airport)
    plane.land_at(airport)
    airport.park(plane)
  end

  def launch_sequence(airport,airspace)
    until airport.planes.empty? do
      airspace << airport.launch!
    end
  end