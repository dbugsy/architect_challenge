class Plane

  def initialize
    takeoff!
    @permission_to_land = false
  end

  attr_reader :flying_status
  attr_writer :permission_to_land

  def check_landing_conditions 
    raise 'Cannot land without permission. Maintaining altitude.' if !@permission_to_land
    raise 'Are you tripping? You are already on the ground!' if @flying_status == :landed
    true
  end 

  def land_at(airport)
    self.check_landing_conditions
    airport.park(self)
    @flying_status = :landed
  end

  def takeoff!
    raise 'You cannot take off when you are already flying.' if @flying_status == :flying
    @flying_status = :flying
  end

  def request_permission_to_land(airport)
    airport.check_permission_to_land(self)
  end

end