require 'ocr_kata_ruby'

describe Accounts_File do
  before(:each) do
    @accounts_file_path = File.new("lib/accounts.txt")
    subject.read_accounts_file(@accounts_file_path)
  end

  it "can read in account number entries from a text file" do
    subject.accounts_file_lines.length.should == 52
  end


  context "an individual account number" do
    before(:each) do
      subject.subdivide_file_into_entries
    end

    it "can subdivide a text file into separate account numbers" do
      subject.entries.length.should == 13
    end

    it "can subdivide an account number into nine separate digit positions" do
      subject.entries[0].raw_digit_blocks.length.should == 9
    end

    it "can correctly read in a digit in a digit position" do
      subject.entries[0].raw_digit_blocks[0].should == " _ | ||_|"
    end

    it "can identify a digit under ideal conditions" do
      subject.entries[0].digits[0].should == 0
    end

    it "can identify an entire account number under ideal conditions" do
      subject.entries[10].digits.join.should == "123456789"
    end

    context "an individual entry" do
      it "can identify when an entry has an invalid checksum" do
        subject.entries[1].checksum_valid?.should == false
      end

      it "can identify when an entry has a valid checksum" do
        subject.entries[11].checksum_valid?.should == true
      end
      it "can report whether it is an erroneous account number" do
        subject.entries[9].report.should == "999999999 ERR"
      end

      it "can report whether it is an illegible account number" do
        subject.entries[12].report.should == "88888888? ILL"
      end
    end
  end
end
