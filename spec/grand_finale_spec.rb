require 'airport'
require 'plane'

describe "The grand finale (last spec)" do
  
  it 'all planes can land and all planes can take off' do
  airspace = []
  lhr = Airport.new(6)
  lhr.stub(:stormy?).and_return(false)
  6.times {airspace << Plane.new}
  airspace.each {|plane| lhr.land!(plane)}
  expect(lhr.full?).to be_true
  expect(lhr.planes.count).to eq 6
  until lhr.planes.empty? do
    lhr.takeoff!
  end
  expect(lhr.planes).to eq []
  end
end
