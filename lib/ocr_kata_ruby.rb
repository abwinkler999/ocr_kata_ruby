class Check
	attr_accessor :raw_digits, :digits, :lines

	def initialize
		@raw_digits = []
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
				temp_check.raw_digits << [x[0][digit_pos, 3], x[1][digit_pos, 3], x[2][digit_pos, 3]].join
				temp_check.digits << match_digit([x[0][digit_pos, 3], x[1][digit_pos, 3], x[2][digit_pos, 3]].join)
			}
			# there's got to be a way to dry this out
			@checks << temp_check
		}
	end


	def match_digit(candidate)
		case candidate
		when " _ | ||_|"
			return 0
		when "     |  |"
			return 1
		when " _  _||_ "
			return 2
		when " _  _| _|"
			return 3
		when "   |_|  |"
			return 4
		when " _ |_  _|"
			return 5
		when " _ |_ |_|"
			return 6
		when " _   |  |"
			return 7
		when " _ |_||_|"
			return 8
		when " _ |_| _|"
			return 9
		else
			return -1
		end
	end

end