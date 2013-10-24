require 'accounts_file'
require 'entry'

FILE_LENGTH = 20
NUMBER_OF_ENTRIES = 5
DIGIT_SEGMENTS = 9

describe AccountsFile do
  before(:each) do
    @accounts_file_path = File.new("lib/accounts.txt")
    subject.read_accounts_file(@accounts_file_path)
  end

  it "can read in account number entries from a text file" do
    subject.accounts_file_lines.length.should == FILE_LENGTH
  end

  context "an individual account number" do
    before(:each) do
      subject.subdivide_file_into_entries
    end

    it "can subdivide a text file into separate account numbers" do
      subject.entries.length.should == NUMBER_OF_ENTRIES
    end

    it "can subdivide an account number into nine separate digit positions" do
      subject.entries[0].raw_digit_blocks.length.should == DIGIT_SEGMENTS
    end

    it "can correctly read in a digit in a digit position" do
      subject.entries[0].raw_digit_blocks[0].should == " _ " +
                                                       "| |" +
                                                       "|_|"
    end

    it "can identify a digit under ideal conditions" do
      subject.entries[0].identified_digits[0].should == 0
    end

    it "can identify an entire account number under ideal conditions" do
      subject.entries[1].identified_digits.join.should == "123456789"
    end

    it "can identify when an entry has an invalid checksum" do
      subject.entries[2].checksum_valid?.should == false
    end

    it "can identify when an entry has a valid checksum" do
      subject.entries[3].checksum_valid?.should == true
    end

    it "can report whether it is an erroneous account number" do
      subject.entries[2].report.should == "999999999 ERR"
    end

    it "can report whether it is an illegible account number" do
      subject.entries[4].report.should == "88888888? ILL"
    end

  end

  context "an individual digit" do
    it "can report all possibilities of a single read digit" do
      subject.entries[0].identified_digits[0].alternatives.should == [0,8]
    end
  end
end
