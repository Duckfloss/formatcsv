require 'minitest/autorun'
require './lib/formatcsv'
require 'pry'

class FormatCSVTest < Minitest::Test
	def setup
		@write = FormatCSV::Write.new
	end
	def test_this
#binding.pry
		assert_equal "It works",
			@write.now
	end
end