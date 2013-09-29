require 'ocr_kata_ruby'

describe Check_Set do
	before(:each) do
		check_file = File.new("lib/checks.txt")
	end

	it "can read an entry from a text file" do
		subject.read_checks(check_file)
		subject.check_data.length.should == 108 # four lines of 27 characters each
	end

end
