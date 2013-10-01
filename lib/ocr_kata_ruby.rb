class Check
  attr_accessor :raw_digits, :digits, :lines

  def initialize
    @raw_digits = []
    @digits = []
    @lines = []
  end
end

class Check_File
  attr_accessor :check_file_lines, :entries

  def initialize
    @check_file_lines = []
    @entries = []
  end

  def read_checks(check_file_path)
    @check_file_lines = IO.readlines(check_file_path)
  end

  def subdivide_file_into_checks
    @check_file_lines.each_slice(4).to_a.each { |x| 
      temp_check = Check.new
      temp_check.lines = x
      #puts {"hi "+ "there"}
      for digit_number in 0..8
        line_position = digit_number * 3
        temp_check.raw_digits << [x[0][line_position, 3], x[1][line_position, 3], x[2][line_position, 3]].join
        temp_check.digits << match_digit([x[0][line_position, 3], x[1][line_position, 3], x[2][line_position, 3]].join)
      end
      @entries << temp_check
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