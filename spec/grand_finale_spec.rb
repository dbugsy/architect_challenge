require 'airport'
require 'plane'
# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!
describe "The grand finale (last spec)" do
  let (:timbuktu) {Airport.new}
  let (:airspace) {Array.new}
  
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

  # method launch test planes through ever-changing weather
  def launch_sequence(airport,airspace)
    until airport.planes.empty? do
      airspace << airport.launch!
      airspace.select! {|element| element.class == Plane}
    end
  end
  
  it 'all planes should land' do
    #create 6 planes in airspace around timbuktu airport
    6.times {airspace << Plane.new}
    # land the planes
    6.times do landing_plane=airspace.pop
      landing_sequence(landing_plane,timbuktu)
      end
    # test the planes (should have status :landed and all should be parked)
    expect(timbuktu.planes.count).to eq 6
    expect(airspace.count).to eq 0
    expect(timbuktu.planes[0].flying_status).to eq :landed
    expect(timbuktu.planes[5].flying_status).to eq :landed
  end

  it 'all planes should take off' do
    # create environment with 6 landed planes
    6.times {landing_sequence(Plane.new,timbuktu)}
    # launch all the planes into airspace
    launch_sequence(timbuktu,airspace)
    # test the conditions
    expect(timbuktu.planes.count).to eq 0
    expect(airspace.count).to eq 6
    expect(airspace[1].flying_status).to eq :flying
    expect(airspace[5].flying_status).to eq :flying
  end
end