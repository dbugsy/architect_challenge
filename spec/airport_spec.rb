require 'airport'
require 'plane'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land
describe Airport do
  let (:airport) { Airport.new }
  let (:plane) { double :plane }

  def land_a_plane(airport, plane)
    expect(plane).to receive(:land!)
    airport.land!(plane)
  end

  context 'when an instance is created' do
    before :each do
      airport.stub(:stormy?).and_return(false)
    end

    it 'it has no planes' do
      expect(airport.planes.empty?).to be_true
    end

    it 'it will be full if ten planes land' do
      10.times { land_a_plane(airport, plane) }
      expect(airport.full?).to be_true
    end

  end

  context 'landing and taking off in good weather' do
    before :each do
      airport.stub(:stormy?).and_return(false)
    end

    it 'commands a plane to land' do
      expect(plane).to receive(:land!)
      airport.land!(plane)
    end

    it 'a plane can land' do
      land_a_plane(airport, plane)
      expect(airport.planes.count).to eq 1
    end

    it 'a plane cannot land if the airport is full' do
      10.times { land_a_plane(airport, plane) }
      expect {airport.land!(plane)}.to raise_error 'Airport full! Please try again later.'
    end

    it 'a plane can takeoff!' do
      land_a_plane(airport, plane)
      expect(plane).to receive(:takeoff!)
      airport.takeoff!(plane)
      expect(airport.planes.empty?).to be_true
    end

  end



  # Include a weather condition using a module.
  # The weather must be random and only have two states "sunny" or "stormy".
  # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
  #
  # This will require stubbing to stop the random return of the weather.
  # If the airport has a weather condition of stormy,
  # the plane can not land, and must not be in the airport
  context 'bad weather conditions' do

    before :each do
      airport.stub(:stormy?).and_return(true)
    end

    it 'can be stormy' do
      expect(airport.stormy?).to be_true
    end

    it 'a plane cannot take off when there is a storm brewing' do
      expect{airport.takeoff!(plane)}.to raise_error 'Stormy weather - runway closed!'
    end

    xit 'a plane cannot land in the middle of a storm' do
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
  let(:airport) {double :airport}
  it 'has a flying status when created' do
    expect(plane.flying?).to be_true
  end

  it 'can land' do
    plane.land!
    expect(plane.flying?).to be_false
  end

  it 'can take off' do
    plane.land!
    plane.takeoff!
    expect(plane.flying?).to be_true
  end

  it 'raises an error if you try to land a plane that is not flying' do
    plane.land!
    expect {plane.land!}.to raise_error 'Are you high? This plane is already landed!'
  end

  it 'raises an error if you try to takeoff when already in the air' do
    expect {plane.takeoff!}.to raise_error 'This is not a spaceship. You cannot takeoff when already flying!'
  end
end

# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!
describe "The gand finale (last spec)" do
  xit 'all planes can land and all planes can take off' do
  end
end
