class Entry
  attr_accessor :raw_digit_blocks, :identified_digits, :lines

  def initialize
    @raw_digit_blocks = []
    @identified_digits = []
    @lines = []
  end

  def checksum_valid?
    checksum = 0
    (NUMBER_OF_DIGITS-1).downto(0) { |current_digit|
      checksum += (identified_digits[current_digit] * (9 - current_digit))
    }
    ((checksum % 11) == 0)
  end

  def report
    output_line = identified_digits.join.to_s
    if identified_digits.include?("?")
      output_line += " ILL"
    elsif !checksum_valid? 
      output_line += " ERR"
    end
    output_line
  end
end