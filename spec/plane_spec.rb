require 'plane'
require 'weather_inquirer_spec'

# When we create a new plane, it should have a "flying" status, thus planes can not be created in the airport.
#
# When we land a plane at the airport, the plane in question should have its status changed to "landed"
#
# When the plane takes of from the airport, the plane's status should become "flying"

describe Plane do

  let(:plane) { Plane.new }
  let(:airport) {double :airport}

  it_behaves_like 'a weather inquirer'
  
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
      airport = double :airport, {:let_land => false}  #, :land => plane.confirm_landing}
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

    it 'can do non-requested take-off if weather okay' do
      plane.stub(weather_good?: true)
      airport = double :airport, { :confirm_took_off => nil }
      plane.confirm_landing
      plane.take_off_from airport
      expect(plane.status).to eq "flying"
    end

    it 'cannot take-off if weather stormy' do
      plane.stub(weather_good?: false)
      plane.confirm_landing
      plane.take_off_from airport
      expect(plane.status).to eq "landed"
    end

    it 'returns message if too stormy to take-off' do
      plane.stub(weather_good?: false)
      plane.confirm_landing
      expect(plane.take_off_from airport).to eq "Sorry. Too Stormy to take off"
    end


    it 'informs airport of non-requested take-off' do
      plane.stub(weather_good?: true)
      plane.confirm_landing
      expect(airport).to receive(:confirm_took_off).with (plane)
      plane.take_off_from airport
    end 

  end  


end




