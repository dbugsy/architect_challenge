require 'airport'

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
      airport.takeoff!
      expect(airport.planes.empty?).to be_true
    end

  end

  context 'bad weather conditions' do

    before :each do
      airport.stub(:stormy?).and_return(true)
    end

    it 'can be stormy' do
      expect(airport.stormy?).to be_true
    end

    it 'a plane cannot take off when there is a storm brewing' do
      expect(plane).not_to receive(:takeoff!)
      expect{airport.takeoff!}.to raise_error 'Stormy weather!'
    end

    it 'a plane cannot land in the middle of a storm' do
      expect(plane).not_to receive(:land!)
      expect{airport.land!(plane)}.to raise_error 'Stormy weather - runway closed!'
    end
  end
end
