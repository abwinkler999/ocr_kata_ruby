class Check
  attr_accessor :raw_digit_blocks, :digits, :lines

  def initialize
    @raw_digit_blocks = []
    @digits = []
    @lines = []
  end

  def checksum_valid?
    checksum = 0
    8.downto(0) { |x|
      checksum += (digits[x] * (9 - x))
    }
    puts checksum
    return ((checksum % 11) == 0)
  end

  def report
    output_line = digits.join.to_s
    if !checksum_valid? 
      output_line += " ERR"
    end
    return output_line
  end
end

class Check_File
  attr_accessor :check_file_lines, :entries

  def initialize
    @check_file_lines = []
    @entries = []
  end

  def read_check_file(check_file_path)
    @check_file_lines = IO.readlines(check_file_path)
  end

  def subdivide_file_into_checks
    @check_file_lines.each_slice(4).to_a.each { |x| 
      temp_check = Check.new
      temp_check.lines = x
      for digit_number in 0..8
        read_at = digit_number * 3
        temp_check.raw_digit_blocks << [x[0][read_at, 3], x[1][read_at, 3], x[2][read_at, 3]].join
        temp_check.digits << identify_digit(temp_check.raw_digit_blocks[digit_number])
      end
      @entries << temp_check
    }
    # to do: refactor this with "step" method
  end

  def identify_digit(candidate)
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