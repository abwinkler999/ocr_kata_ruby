require 'ocr_kata_ruby'

describe Check_Set do
	before(:each) do
		@check_file_path = File.new("lib/checks.txt")
		subject.read_checks(@check_file_path)
	end

	it "can read in check entries from a text file" do
		subject.check_file_lines.length.should == 44
	end

	it "can subdivide a text file into separate checks" do
		subject.subdivide_file_into_checks
		subject.checks.length.should == 11
	end

	it "can subdivide a check into separate digits" do
		subject.subdivide_file_into_checks
		subject.checks[0].digits[0].should == " _ | ||_|"
		subject.checks[0].digits.length.should == 9
	end


	it "can identify a digit under ideal conditions" do
		#subject.subdivide_into_checks
		#subject.checks[0].digits[0]
	end

end
