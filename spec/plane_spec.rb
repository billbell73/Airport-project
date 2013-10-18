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

  it 'can take off' do
    plane.take_off
    expect(plane.status).to eq "flying"
  end

  it 'changes its status to flying after taking off' do
    plane.landed
    plane.take_off
    expect(plane.status).to eq "flying"
  end


  it 'is knows it is on ground when it has landed' do
    plane.landed
    expect(plane.status).to eq "landed"
  end

end
  


# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!
# describe "The gand finale (last spec)" do
#   it 'all planes can land and all planes can take off' do
#   end




# it 'can request to land at an airport' do
  #   airport = double :airport
  #   expect(airport).to receive (:ok_to_land?)
  #   plane.request_to_land_at? airport
  # end

  # it 'can land after receiving airport\'s permission' do
  #   airport = double :airport, {:ok_to_land? => true, :landed => nil}
  #   plane.request_to_land_at? airport
  #   plane.land_at airport
  #   expect(plane.status).to eq "landed"
  # end

  # it "tells airport when it lands" do
  #   airport = double :airport, {:ok_to_land? => true, :landed => nil}
  #   expect(airport).to receive(:landed)
  #   plane.land_at airport
  # end
  
  
  # it 'has a flying status when in the air' do
  # end
#end
