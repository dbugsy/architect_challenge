require 'plane'

describe Plane do

  # When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
  #
  # When we land a plane at the airport, the plane in question should have its status changed to "landed"
  #
  # When the plane takes of from the airport, the plane's status should become "flying"

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