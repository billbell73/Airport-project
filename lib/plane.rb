class Plane

	attr_reader :status

	def initialize 
		@status = "flying"
	end

	def request_to_land_at? airport
		airport.ok_to_land?
	end

	def land_at airport
		if request_to_land_at? airport
			@status = "landed" 
			airport.landed
		end
	end

	#def take_off


end