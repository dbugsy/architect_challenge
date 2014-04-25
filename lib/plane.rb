class Plane

  def initialize
    @flying = true
  end

  def flying?
    @flying
  end

  def land!
    raise 'Are you high? This plane is already landed!' if !@flying
    @flying = false
  end

  def takeoff!
    raise 'This is not a spaceship. You cannot takeoff when already flying!' if @flying
    @flying = true
  end

end