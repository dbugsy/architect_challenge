class Plane

  def initialize
    takeoff!
    @permission_to_land = false
  end

  attr_reader :flying_status
  attr_writer :permission_to_land

  def land!(airport)
    return 'Cannot land without permission. Maintaining altitude.' if !@permission_to_land
    return 'Are you tripping? You are already on the ground!' if @flying_status == :landed
    airport.park(self)
    @flying_status = :landed
    @permission_to_land = false
  end

  def takeoff!
    return 'You cannot take off when you are already flying.' if @flying_status == :flying
    @flying_status = :flying
  end

  def request_permission_to_land(airport)
    airport.check_permission_to_land(self)
  end

end