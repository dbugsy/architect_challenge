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
  let(:hackney) {Airport.new(capacity: 2)}
  let(:plane) {double :plane}

  context 'When a new airport is created, it..' do
    it 'is created with no planes' do
        expect(airport.planes).to eq []
    end

    it 'should have a default capacity of 10' do
      expect(airport.capacity).to eq 10
    end

    it 'should be able to receive an initialize argument to make capacity 2' do
      expect(hackney.capacity).to eq 2
    end

    it 'should know when it is full' do
      expect(plane).to receive(:land!).twice
      2.times {hackney.land(plane)}
      expect(hackney.full?).to be_true
    end

    it 'should know when it is not full' do
      expect(plane).to receive(:land!)
      expect(hackney.full?).to be_false
      hackney.land(plane)
    end

  end
  
  context 'taking off and landing' do
    it 'a plane can land' do
      expect(plane).to receive(:land!)
      airport.land(plane)
      expect(airport.planes.count).to eq 1
    end
    
    it 'a plane can take off' do
      expect(plane).to receive(:land!)
      expect(plane).to receive(:takeoff!)
      hackney.land(plane)
      hackney.launch!
      expect(hackney.planes.count).to eq 0  
    end
  end
  
  context 'traffic control' do
    
    it 'a plane cannot land if the airport is full' do
      expect(plane).to receive(:land!).exactly(10).times
      11.times {airport.land(plane)}
      expect(airport.land(plane)).to eq 'Permission Denied: Airport Full!'
    end
    
    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport
    context 'weather conditions' do
      it 'a plane cannot take off when there is a storm brewing' do
      end
      
      it 'a plane cannot land in the middle of a storm' do
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
  
  it 'has a flying status when created' do
    expect(plane.flying_status).to eq :flying
  end

  it 'can land' do
    plane.land!
    expect(plane.flying_status).to eq :landed
  end
  
  it 'has a flying status when in the air' do
  end
  
  it 'can take off' do
  end
  
  it 'changes its status to flying after taking of' do
  end
end

# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!
describe "The gand finale (last spec)" do
  it 'all planes can land and all planes can take off' do
  end
end
