module WeatherConditions

  def the_whim_of_the_gods
  	Random.new.rand(1..5)
  end

  def weather_check
  	return :stormy if self.the_whim_of_the_gods == 1
  	:sunny
  end

end