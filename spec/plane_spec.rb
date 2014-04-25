require 'plane'

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