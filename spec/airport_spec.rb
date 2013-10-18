require 'airport'

# A plane currently in the airport can be requested to take off.
#
# No more planes can be added to the airport, if it's full.
# It is up to you how many planes can land in the airport and how that is impermented.
#
# If the airport is full then no planes can land
describe Airport do
  let(:airport) { Airport.new }

  let(:plane) {double :plane}
  
  it 'has a default capacity of 3 when created' do
    expect(airport.capacity).to eq 3
  end

  # it 'can check weather status' do
  #   expect(airport.weather_status).to eq "sunny" or "stormy"
  # end

  context 'taking off and landing' do

    it 'a plane can land' do
      plane = double :plane, {:landed => nil}
      airport.land plane
      expect(airport.planes_on_ground).to eq [plane]
    end

    it 'a plane is told that it has landed' do
      expect(plane).to receive (:landed)
      airport.land plane
    end


    
  #   it 'a plane can take off' do
  #   end
  # end

    it 'can request that a plane takes off' do
      plane = double :plane
      expect(plane).to receive (:take_off)
      airport.request_take_off_to plane
    end

    it 'after take-off, plane is no longer at airport' do
      plane = double :plane, { take_off: nil, landed: nil }
      airport.land plane
      expect(airport.remove_from_planes_on_ground plane).to eq plane
      airport.request_take_off_to plane
    end

  end

  
  # context 'traffic control' do

      it 'can tell if it is full' do
        plane = double :plane, {:landed => nil}
        plane2 = double :plane2, {:landed => nil}
        plane3 = double :plane3, {:landed => nil}
        airport.land plane
        airport.land plane2
        airport.land plane3
        expect(airport.full?).to eq true
      end

      it 'can tell if it is not full' do
        plane = double :plane, {:landed => nil}
        plane2 = double :plane2, {:landed => nil}
        airport.land plane
        airport.land plane2
        expect(airport.full?).to eq false
      end


      it 'a plane cannot land if the airport is full' do
        plane = double :plane, {:landed => nil}
        plane2 = double :plane2, {:landed => nil}
        plane3 = double :plane3, {:landed => nil}
        airport.land plane
        airport.land plane2
        airport.land plane3
        plane4 = double :plane4, {:landed => nil}
        airport.land plane4
        expect(airport.planes_on_ground.include?(plane4)).to eq false
      end
    
    # Include a weather condition using a module.
    # The weather must be random and only have two states "sunny" or "stormy".
    # Try and take off a plane, but if the weather is stormy, the plane can not take off and must remain in the airport.
    # 
    # This will require stubbing to stop the random return of the weather.
    # If the airport has a weather condition of stormy,
    # the plane can not land, and must not be in the airport
#     context 'weather conditions' do
#       it 'a plane cannot take off when there is a storm brewing' do
#       end
      
#       it 'a plane cannot land in the middle of a storm' do
#       end
#     end
#   end


# it 'can respond to request to land' do
  #   plane = double :plane

  # end

# it 'knows when a plane has landed' do
  #   plane = double :planes
  #   airport.landed
  # end
end