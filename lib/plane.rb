class Plane

	attr_reader :status

	def initialize 
		@status = "flying"
	end

	def do_requested_take_off
		@status = "flying"
	end

	def request_to_land_at? airport
    airport.okay_to_land?
  end

  def land_at airport
  	if request_to_land_at? airport
  		airport.let_land self
  	end
  end

  def take_off
		@status = "flying"
	end

	def confirm_landing
		@status = "landed"
	end

end