require 'plane'
require 'airport'

# grand final
# Given 6 planes, each plane must land. When the airport is full, every plane must take off again.
# Be careful of the weather, it could be stormy!
# Check when all the planes have landed that they have the right status "landed"
# Once all the planes are in the air again, check that they have the status of flying!

describe "The grand finale (last spec)" do

	let (:plane1) { Plane.new }
	let (:plane2) { Plane.new }
	let (:plane3) { Plane.new }
	let (:plane4) { Plane.new }
	let (:plane5) { Plane.new }
	let (:plane6) { Plane.new }

	let (:airport) { Airport.new(6) }


		it 'all planes can land' do
			airport.stub(:weather_good? => true)
			airport.land plane1
			airport.land plane2
			airport.land plane3
			airport.land plane4
			airport.land plane5
			airport.land plane6
			expect(airport.planes_on_ground).to eq [plane1, plane2, plane3, plane4, plane5, plane6]
			expect(plane1.status).to eq "landed"
			expect(plane5.status).to eq "landed"
			plane7 = Plane.new
			plane7.land_at airport
			expect(airport.planes_on_ground).to eq [plane1, plane2, plane3, plane4, plane5, plane6]
			expect(plane7.status).to eq "flying"
		#end

		# it 'plane cannot land if airport full' do
		# 	plane7 = Plane.new
		# 	plane7.land_at airport
		# 	expect(airport.planes_on_ground).to eq [plane1, plane2, plane3, plane4, plane5, plane6]
		# 	expect(plane7.status).to eq "flying"
		# end

		#it 'all planes can take off again' do
			airport.request_take_off_to plane1
			airport.request_take_off_to plane2
			airport.request_take_off_to plane3
			airport.request_take_off_to plane4
			airport.request_take_off_to plane5
			airport.request_take_off_to plane6
			expect(airport.planes_on_ground).to eq []
			expect(plane2.status).to eq "flying"
			expect(plane2.status).to eq "flying"
		end

		it 'can land at airport of choice' do
			airport.stub(:weather_good? => true)
			plane1.land_at airport
			expect(plane1.status).to eq "landed"
			expect(airport.planes_on_ground).to eq [plane1]
		end

end


  
  