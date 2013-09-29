require 'ocr_kata_ruby'

describe Check_Set do
	before(:each) do
		@check_file_path = File.new("lib/checks.txt")
	end

	it "can read an entry from a text file containing one check" do
		subject.read_checks(@check_file_path)
		subject.check_file.length.should == 4
	end
	

end
