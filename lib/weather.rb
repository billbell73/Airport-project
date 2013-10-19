module Weather

	def weather_status
		["sunny", "sunny", "stormy"].sample
	end

	def weather_good?
		weather_status == "sunny"
	end

end