require 'airport'

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










