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

	def subdivide_file_into_checks
		@check_file_lines.each_slice(4).to_a.each { |x| 
			temp_check = Check.new
			temp_check.lines = x
			[0, 3, 6, 9, 12, 15, 18, 21, 24].each { |digit_pos|
				temp_check.digits << [x[0][digit_pos, 3], x[1][digit_pos, 3], x[2][digit_pos, 3]].join
			}
			# there's got to be a way to dry this out
			@checks << temp_check
		}

	end

end