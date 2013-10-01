require 'ocr_kata_ruby'

describe Check_File do
  before(:each) do
    @check_file_path = File.new("lib/checks.txt")
    subject.read_checks(@check_file_path)
    subject.subdivide_file_into_checks
  end

  it "can read in check entries from a text file" do
    subject.check_file_lines.length.should == 44
  end

  it "can subdivide a text file into separate checks" do
    subject.entries.length.should == 11
  end

  it "can subdivide a check into nine separate digits" do
    subject.entries[0].raw_digits[0].should == " _ | ||_|"
    subject.entries[0].raw_digits.length.should == 9

  end


  it "can identify a digit under ideal conditions" do
    subject.entries[0].digits[0].should == 0
  end

  it "can OCR an entire check under ideal conditions" do
    subject.entries[10].digits.join.should == "123456789"
  end
end
