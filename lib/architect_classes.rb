require_relative './airport'
require_relative './plane'

def navigate_storm(plane,airport)
	until plane.instance_variable_get(:@permission_to_land)
	  plane.request_permission_to_land_at(airport)
	end
end

def land_planes(planes,airport)
planes.each {|plane| plane.land_at(airport)}
end

def park_planes(planes,airport)
planes.each {|plane| airport.park(plane)}
end

def landing_sequence(plane,airport)
navigate_storm(plane, airport)
plane.land_at(airport)
airport.park(plane)
end

timbuktu = Airport.new
airspace = []

6.times {airspace << Plane.new}

6.times {landing_plane=airspace.pop
    landing_sequence(landing_plane,timbuktu)}

puts timbuktu.inspect
puts airspace.inspect

