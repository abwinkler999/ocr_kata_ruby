class Check_Set
	attr_accessor :check_file

	def initialize
		@check_file = []
	end

	def read_checks(check_file_path)
		@check_file = IO.readlines(check_file_path)
	end

end