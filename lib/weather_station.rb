module WeatherStation

	def weather_status
		["sunny", "sunny", "stormy"].sample
	end

	def weather_good?
		weather_status == "sunny"
	end

	def stormy_abort_take_off_msg
		"Sorry. Too Stormy to take off"
	end

end