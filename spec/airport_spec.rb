require 'airport'
require 'weather_inquirer_spec'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land

describe Airport do
  
  let(:airport) { Airport.new }

  let(:plane) { double :plane }

  it_behaves_like 'a weather inquirer'

  context 'capacity' do
  
    it 'has a default capacity of 3 when created' do
      expect(airport.capacity).to eq 3
    end

  end

  context 'taking off and landing' do

    it 'a plane can land' do
      airport.stub(weather_good?: true)
      plane = double :plane, confirm_landing: nil
      airport.let_land plane
      expect(airport.planes_on_ground).to eq [plane]
    end

    it 'a message goes to plane confirming landing' do
      airport.stub(weather_good?: true)
      expect(plane).to receive (:confirm_landing)
      airport.let_land plane
    end
    
    it 'a plane can take off' do
      airport.stub(weather_good?: true)
      plane = double :plane, do_requested_take_off: nil, confirm_landing: nil
      airport.let_land plane
      airport.request_take_off_to plane
      expect(airport.planes_on_ground).to eq []
    end

    it 'airport can request that a plane takes off' do
      airport.stub(:weather_good? => true)
      plane = double :plane
      expect(plane).to receive (:do_requested_take_off)
      airport.request_take_off_to plane
    end

    it 'after such take-off, plane is no longer at airport' do
      airport.stub(:weather_good? => true)
      plane = double :plane, { do_requested_take_off: nil, confirm_landing: nil }
      airport.let_land plane
      expect(airport.remove_from_planes_on_ground plane).to eq plane
      airport.request_take_off_to plane
    end

    it 'after non-requested take-off, plane also gone' do
      airport.stub(:weather_good? => true)
      plane = double :plane, confirm_landing: nil
      airport.let_land plane
      expect(airport.remove_from_planes_on_ground plane).to eq plane
      airport.confirm_took_off plane
    end

  end

  
  context 'traffic control' do

      it 'can tell if airport is full' do
        airport.stub(:weather_good? => true)
        plane = double :plane, {:confirm_landing => nil}
        plane2 = double :plane2, {:confirm_landing => nil}
        plane3 = double :plane3, {:confirm_landing => nil}
        airport.let_land plane
        airport.let_land plane2
        airport.let_land plane3
        expect(airport.full?).to eq true
      end

      it 'can tell if airport is not full' do
        airport.stub(:weather_good? => true)
        plane = double :plane, {:confirm_landing => nil}
        plane2 = double :plane2, {:confirm_landing => nil}
        airport.let_land plane
        airport.let_land plane2
        expect(airport.full?).to eq false
      end


      it 'a plane cannot land if airport is full' do
        airport.stub(:weather_good? => true)
        plane = double :plane, {:confirm_landing => nil}
        plane2 = double :plane2, {:confirm_landing => nil}
        plane3 = double :plane3, {:confirm_landing => nil}
        airport.let_land plane
        airport.let_land plane2
        airport.let_land plane3
        plane4 = double :plane4, {:confirm_landing => nil}
        airport.let_land plane4
        expect(airport.planes_on_ground.include?(plane4)).to eq false
      end

      it 'returns message if plane tries to land but airport full' do
        airport.stub(:weather_good? => true)
        plane = double :plane, {:confirm_landing => nil}
        plane2 = double :plane2, {:confirm_landing => nil}
        plane3 = double :plane3, {:confirm_landing => nil}
        airport.let_land plane
        airport.let_land plane2
        airport.let_land plane3
        plane4 = double :plane4, {:confirm_landing => nil}
        expect(airport.let_land plane4).to eq "Sorry. Cannot land - airport full!"
      end

    end
    
    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
  #   the plane can not land, and must not be in the airport

    context 'weather conditions' do

      # it 'can check weather status' do
      #   airport = double :airport, {weather_status: "sunny"}
      #   expect(airport.weather_status).to eq "sunny"
      # end

      # it 'can tell whether okay to land' do
      #   airport.stub(:weather_good? => true)
      #   expect(airport.okay_to_land?).to be_true
      # end

      # it 'can tell if weather good' do
      #   airport.stub(:weather_good? => true)
      #   expect(airport.weather_good?).to be_true
      # end

      it 'a plane cannot do requested take off when storm brewing' do
        airport.stub(:weather_good? => false)
        airport.request_take_off_to plane
        expect(plane).not_to receive (:do_requested_take_off)
      end

      it 'returns message if too stormy for take-off' do
        airport.stub(:weather_good? => false)
        expect(airport.request_take_off_to plane).to eq "Sorry. Too Stormy to take off"
      end
      
      it 'a plane cannot land in the middle of a storm' do
        airport.stub(:weather_good? => false)
        plane = double :plane, {:confirm_landing => nil}
        airport.let_land plane
        expect(airport.planes_on_ground).to eq []
      end

      it 'returns message if too stormy to land' do
        airport.stub(:weather_good? => false)
        plane = double :plane, {:confirm_landing => nil}
        expect(airport.let_land plane).to eq "Sorry. Too Stormy to land. Good luck!"
      end

    end

    context 'weather conditions & airport capacity' do

      it 'can tell if okay to land' do
        airport.stub(:weather_good? => true)
        expect(airport.okay_to_land?).to be_true
      end

      it 'can tell that not okay to land if weather bad' do
        airport.stub(:weather_good? => false)
        expect(airport.okay_to_land?).to be_false
      end

      it 'can tell that not okay to land if airport full' do
        airport.stub(:weather_good? => true)
        plane = double :plane, {:confirm_landing => nil}
        plane2 = double :plane2, {:confirm_landing => nil}
        plane3 = double :plane3, {:confirm_landing => nil}
        airport.let_land plane
        airport.let_land plane2
        airport.let_land plane3
        expect(airport.okay_to_land?).to be_false
      end



    end

end

