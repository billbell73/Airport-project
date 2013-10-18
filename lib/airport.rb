require_relative 'weather'

class Airport

	include Weather

	attr_reader :capacity, :planes_on_ground

	def initialize(capacity=3)
		@capacity = capacity
		@planes_on_ground = []
	end

	def request_take_off_to plane
		plane.take_off_please
	end

	def land plane
		@planes_on_ground << plane
	end


	# def ok_to_land?
	# 	space_available? and good_weather? and no_plane_approaching?
	# end

	#def landed




end