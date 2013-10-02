require 'ocr_kata_ruby'

# sample check file checks.txt contains twelve entries

describe Check_File do
  before(:each) do
    @check_file_path = File.new("lib/checks.txt")
    subject.read_check_file(@check_file_path)
  end

  it "can read in check entries from a text file" do
    subject.check_file_lines.length.should == 48
  end


  context "an individual check" do
    before(:each) do
      subject.subdivide_file_into_checks
    end

    it "can subdivide a text file into separate checks" do
      subject.entries.length.should == 12
    end

    it "can subdivide a check into nine separate digit positions" do
      subject.entries[0].raw_digit_blocks.length.should == 9
    end

    it "can correctly read in a digit in a digit position" do
      subject.entries[0].raw_digit_blocks[0].should == " _ | ||_|"
    end

    it "can identify a digit under ideal conditions" do
      subject.entries[0].digits[0].should == 0
    end

    it "can OCR an entire check under ideal conditions" do
      subject.entries[10].digits.join.should == "123456789"
    end

    context "an individual check number" do
      it "can identify when a check has an invalid checksum" do
        subject.entries[1].checksum_valid?.should == false
      end

      it "can identify when a check has a valid checksum" do
        subject.entries[11].checksum_valid?.should == true
      end
    end
  end
end
