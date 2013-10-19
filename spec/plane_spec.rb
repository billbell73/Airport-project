require 'plane'

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"

describe Plane do

  let(:plane) { Plane.new }
  
  context 'status' do
    
    it 'has \'flying\' status when created' do
      expect(plane.status).to eq "flying"
    end

    it 'has \'flying\' status when in the air' do
      plane.do_requested_take_off
      expect(plane.status).to eq "flying"
    end

  end

  context 'landing' do

    it 'can request to land at an airport' do
      airport = double :airport
      expect(airport).to receive (:okay_to_land?)
      plane.request_to_land_at? airport
    end

    it 'can land after receiving airport\'s permission' do
      airport = double :airport, {:okay_to_land? => true, :let_land => plane.confirm_landing}
      plane.request_to_land_at? airport
      plane.land_at airport
      expect(plane.status).to eq "landed"
    end

    it 'will not land if airport says no' do
      airport = double :airport, {:okay_to_land? => false}  #, :land => plane.confirm_landing}
      plane.land_at airport
      expect(plane.status).to eq "flying"
    end

    it 'knows when it has landed' do
      plane.confirm_landing
      expect(plane.status).to eq "landed"
    end

  end

  context 'taking off' do

    it 'will take off when asked to by airport' do
      plane.do_requested_take_off
      expect(plane.status).to eq "flying"
    end

    it 'changes its status to \'flying\' after taking off' do
      plane.confirm_landing
      plane.do_requested_take_off
      expect(plane.status).to eq "flying"
    end

    

  # it 'can do non-requested take-off if weather okay' do

  # end

  # it 'informs airport that has taken off after non-requested take-off' do

  # end 

  end  


end




