require_relative 'weather_station'

class Plane

	include WeatherStation

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
  		airport.let_land self
  end

  def take_off_from airport
  	if weather_good?
			@status = "flying"
			airport.confirm_took_off self
		else
			stormy_abort_take_off_msg
		end
	end

	def confirm_landing
		@status = "landed"
	end

end