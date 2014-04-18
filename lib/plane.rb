class Plane

  def initialize
    @flying_status = :flying
  end

  attr_reader :flying_status

  def land!
    @flying_status = :landed
  end

end