class Check_Set
	attr_accessor :check_file_lines, :checks

	def initialize
		@check_file_lines = []
		@checks = []
	end

	def read_checks(check_file_path)
		@check_file_lines = IO.readlines(check_file_path)
	end

	def subdivide_checks
	end

end