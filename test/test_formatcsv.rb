require 'minitest/autorun'
require 'formatcsv'

class FormatCSVTest < Minitest::Test
	def test_this
		assert_equal "It works!",
			FormatCSV::Write.new
	end
end