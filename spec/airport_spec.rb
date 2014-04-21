require 'airport'
require 'plane'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land
describe Airport do
  let(:airport) { Airport.new }
  let(:small_airport) {Airport.new(capacity: 2)}
  let(:plane) {double :plane, permission_to_land: true}

  # use this method to create testing environment with a full airport
  def fill(airport)
    allow(airport).to receive(:weather_check) {:sunny}
    ten_planes = []
    10.times {ten_planes << plane}
    airport.instance_variable_set(:@planes, ten_planes)
    airport
  end

  context 'When a new airport is created, it..' do
    it 'is created with no planes' do
        expect(airport.planes).to eq []
    end

    it 'should have a default capacity of 10' do
      expect(airport.capacity).to eq 10
    end

    it 'should be able to receive an initialize argument to make capacity 2' do
      expect(small_airport.capacity).to eq 2
    end

    it 'should know when it is full' do
      expect(fill(airport).full?).to be_true
    end

    it 'should know when it is not full' do
      expect(small_airport.full?).to be_false
    end

  end
  
  context 'taking off and landing' do
    it 'a landed plane can park, thus resetting permission to land' do
      expect(plane).to receive(:flying_status)
      expect(plane).to receive(:permission_to_land=)
      airport.park(plane)
      expect(airport.planes.count).to eq 1
    end
    
    it 'can launch a plane' do
      fill(airport)
      expect(plane).to receive(:takeoff!)
      airport.launch!
      expect(airport.planes.count).to eq 9  
    end
  end
  
  context 'traffic control' do
    
    it 'will grant permission to land when sunny and not full' do
      allow(airport).to receive(:weather_check) {:sunny}
      expect(plane).to receive(:permission_to_land=){true}
      airport.check_permission_to_land(plane)
    end

    it 'will deny permission to land when full' do
      fill(airport)
      expect(airport.check_permission_to_land(plane)).to eq 'Permission Denied: Airport Full!'
    end
    
    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport
    context 'weather conditions' do

      it 'weather is stormy if whim of the gods is 1' do
        allow(airport).to receive(:the_whim_of_the_gods) {1}
        expect(airport.weather_check).to eq :stormy
      end

      it 'weather is sunny if whim of the gods is 2' do
        allow(airport).to receive(:the_whim_of_the_gods) {2}
        expect(airport.weather_check).to eq :sunny
      end

      it 'a plane cannot take off when there is a storm brewing' do
        fill(airport)
        allow(airport).to receive(:weather_check) { :stormy }
        expect(plane).not_to receive(:takeoff!)
        expect(airport.launch!).to eq 'Stormy weather: Runway closed!'
      end
      
      it 'will deny permission to land in the middle of a storm' do
        allow(airport).to receive(:weather_check) { :stormy }
        expect(plane).not_to receive(:permission_to_land=)
        expect(airport.check_permission_to_land(plane)).to eq 'Stormy weather: Runway closed!'
      end

    end
  end
end

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
describe Plane do

  let(:plane) { Plane.new }
  let(:airport) {double :airport, planes: []}

  # this method is used to create environment with a landed plane
  def land(plane)
    plane.permission_to_land=(true)
    plane.instance_variable_set(:@flying_status, :landed)
  end
  
  # instead of testing private state of instance (@flying_status), check results of that state
  it 'cannot takeoff when created as already flying' do
    expect { plane.takeoff! }.to raise_error 'You cannot take off when you are already flying.'
  end

  it 'can test conditions if it can land' do
    plane.permission_to_land=(true)
    expect(plane.check_landing_conditions).to be_true
  end

  it 'cannot land when already landed' do
    land(plane)
    expect(airport).not_to receive(:planes)
    expect { plane.land_at(airport) }.to raise_error 'Are you tripping? You are already on the ground!'
  end

  it 'can request permission to land' do
    expect(airport).to receive(:check_permission_to_land)
    plane.request_permission_to_land_at(airport)
  end

  it 'can land with permission' do
    plane.permission_to_land=(true)
    plane.land_at(airport)
    expect(plane.flying_status).to eq :landed
  end

  it 'cannot land without permission' do
    expect { plane.land_at(airport) }.to raise_error 'Cannot land without permission. Maintaining altitude.'
    expect(plane.flying_status).to eq :flying
  end
  
  it 'can take off' do
    land(plane)
    plane.takeoff!
    expect(plane.flying_status).to eq :flying
  end
  
end

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
  
  





