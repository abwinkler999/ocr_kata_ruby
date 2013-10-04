LINESET_LENGTH = 4
NUMBER_OF_DIGITS = 9
DIGIT_WIDTH = 3

class AccountsFile
  attr_accessor :accounts_file_lines, :entries

  def initialize
    @accounts_file_lines = []
    @entries = []
  end

  def read_accounts_file(accounts_file_path)
    @accounts_file_lines = IO.readlines(accounts_file_path)
  end

  def isolate_raw_digit_blocks(lineset, cursor_position)
    raw_digit_block = []
    for line in 0..2
      raw_digit_block << lineset[line][cursor_position, DIGIT_WIDTH]
    end
    raw_digit_block.join
  end

  def subdivide_file_into_entries
    @accounts_file_lines.each_slice(LINESET_LENGTH).to_a.each { |lineset| 
      temp_entry = Entry.new
      temp_entry.lines = lineset
      for digit_number in 0..(NUMBER_OF_DIGITS-1)
        cursor_position = digit_number * DIGIT_WIDTH
        temp_entry.raw_digit_blocks << isolate_raw_digit_blocks(lineset, cursor_position)
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