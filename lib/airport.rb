class Airport
  
  DEFAULT_CAPACITY = 10

  def initialize(options = {})
    @capacity = options.fetch(:capacity, capacity)
  end

  def capacity
    @capacity ||= DEFAULT_CAPACITY
  end

end