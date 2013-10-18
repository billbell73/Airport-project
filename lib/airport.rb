require_relative 'weather'

class Airport

	include Weather

	attr_reader :capacity, :planes_on_ground

	def initialize(capacity = 3, planes_on_ground = [])
		@capacity = capacity
		@planes_on_ground = planes_on_ground
	end

	def request_take_off_to plane
		plane.take_off
		remove_from_planes_on_ground plane
	end

	def remove_from_planes_on_ground plane
		@planes_on_ground.delete(plane)
	end

	def land plane
		unless full? 
			@planes_on_ground << plane
			plane.landed
		end
	end

	def full?
		@planes_on_ground.length == @capacity
	end


	# def ok_to_land?
	# 	space_available? and good_weather? and no_plane_approaching?
	# end

	#def landed




end