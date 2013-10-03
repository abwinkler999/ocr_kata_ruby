class Entry
  attr_accessor :raw_digit_blocks, :identified_digits, :lines

  def initialize
    @raw_digit_blocks = []
    @identified_digits = []
    @lines = []
  end

  def checksum_valid?
    checksum = 0
    8.downto(0) { |x|
      checksum += (identified_digits[x] * (9 - x))
    }
    return ((checksum % 11) == 0)
  end

  def report
    output_line = identified_digits.join.to_s
    if identified_digits.include?("?")
      output_line += " ILL"
    elsif !checksum_valid? 
      output_line += " ERR"
    end
    return output_line
  end
end

class Accounts_File
  attr_accessor :accounts_file_lines, :entries

  def initialize
    @accounts_file_lines = []
    @entries = []
  end

  def read_accounts_file(accounts_file_path)
    @accounts_file_lines = IO.readlines(accounts_file_path)
  end

  def subdivide_file_into_entries
    @accounts_file_lines.each_slice(4).to_a.each { |x| 
      temp_entry = Entry.new
      temp_entry.lines = x
      for digit_number in 0..8
        read_at = digit_number * 3
        temp_entry.raw_digit_blocks << [x[0][read_at, 3], x[1][read_at, 3], x[2][read_at, 3]].join
        temp_entry.identified_digits << identify_digit(temp_entry.raw_digit_blocks[digit_number])
      end
      @entries << temp_entry
    }
  end

  def identify_digit(candidate)
    case candidate
    when " _ " +
         "| |" +
         "|_|"
      return 0
    when "   " +
         "  |" +
         "  |"
      return 1
    when " _ " +
         " _|" +
         "|_ "
      return 2
    when " _ " +
         " _|" +
         " _|"
      return 3
    when "   " +
         "|_|" +
         "  |"
      return 4
    when " _ " +
         "|_ " +
         " _|"
      return 5
    when " _ " +
         "|_ " +
         "|_|"
      return 6
    when " _ " +
         "  |" +
         "  |"
      return 7
    when " _ " +
         "|_|" + 
         "|_|"
      return 8
    when " _ " +
         "|_|" +
         " _|"
      return 9
    else
      return "?"
    end
  end

end