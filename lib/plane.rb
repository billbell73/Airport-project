class Plane

	attr_reader :status

	def initialize 
		@status = "flying"
	end

	def take_off
		@status = "flying"
	end

	def request_to_land_at airport
    airport.okay_to_land?
  end

  def land_at airport
  	airport.land self
  end

	def landed
		@status = "landed"
	end

end