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
		@check_file_lines.each_slice(4).to_a.each { |x| 
			temp_check = Check.new
			temp_check.lines = x
			temp_check.digits[0] = [x[0][0..2], x[1][0..2], x[2][0..2]].join
			@checks << temp_check
		}

	end

end