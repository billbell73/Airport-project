#something

class Airport

	attr_reader :capacity

	def initialize(capacity=3)
		@capacity = capacity
	end

	def request_take_off_to plane
		plane.take_off_please
	end

	# def ok_to_land?
	# 	true
	# end




end