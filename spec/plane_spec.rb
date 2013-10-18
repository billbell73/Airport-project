require 'plane'

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"
describe Plane do

  let(:plane) { Plane.new }
  
  it 'has a flying status when created' do
    expect(plane.status).to eq "flying"
  end

  # it 'has a flying status when in the air' do
  # end

  it 'can request to land at an airport' do
    airport = double :airport
    expect(airport).to receive (:okay_to_land?)
    plane.request_to_land_at airport
  end

  it 'can land after receiving airport\'s permission' do
    airport = double :airport, {:okay_to_land? => true, :land => plane.landed}
    plane.request_to_land_at airport
    plane.land_at airport
    expect(plane.status).to eq "landed"
  end

  it 'can take off' do
    plane.take_off
    expect(plane.status).to eq "flying"
  end

  it 'changes its status to flying after taking off' do
    plane.landed
    plane.take_off
    expect(plane.status).to eq "flying"
  end

  it 'knows it is on ground when it has landed' do
    plane.landed
    expect(plane.status).to eq "landed"
  end

end




