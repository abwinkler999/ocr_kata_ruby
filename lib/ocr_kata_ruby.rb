class Check
	attr_accessor :digits, :lines

	def initialize
		@digits = []
		@lines = []
	end
end

class Check_Set
	attr_accessor :check_file_lines, :checks

	def initialize
		@check_file_lines = []
		@checks = []
	end

	def read_checks(check_file_path)
		@check_file_lines = IO.readlines(check_file_path)
	end

	def subdivide_into_checks
		@checks = @check_file_lines.each_slice(4).to_a
		# this subdivides into 11 arrays of 4 lines each
	end

end