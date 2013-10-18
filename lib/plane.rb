class Plane

	attr_reader :status

	def initialize 
		@status = "flying"
	end

	def take_off
		@status = "flying"
	end

	def landed
		@status = "landed"
	end

end