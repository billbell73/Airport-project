require_relative 'weather_station'

class Airport

	include WeatherStation

	attr_reader :capacity, :planes_on_ground

	def initialize(capacity = 3)
		@capacity = capacity
		@planes_on_ground = []
	end

	def request_take_off_to plane
		if weather_good?
			plane.do_requested_take_off
			remove_from_planes_on_ground plane
		else
			stormy_abort_take_off_msg
		end
	end

	def remove_from_planes_on_ground plane
		@planes_on_ground.delete(plane)
	end

	def let_land plane
		if okay_to_land?
			@planes_on_ground << plane
			plane.confirm_landing
		elsif full?
			full_msg
		else
			stormy_abort_landing_msg
		end
	end

	def confirm_took_off plane
		remove_from_planes_on_ground plane
	end

	def full?
		@planes_on_ground.length == @capacity
	end

	def okay_to_land?
		!full? and weather_good?
	end

	def stormy_abort_landing_msg
		"Sorry. Too Stormy to land. Good luck!"
	end

	def full_msg
		"Sorry. Cannot land - airport full!"
	end

end