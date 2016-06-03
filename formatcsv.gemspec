$:.unshift File.expand_path("../lib", __FILE__)

require 'formatcsv/version'

Gem::Specification.new do |gem|
	gem.name		= 'formatcsv'
	gem.version		= FormatCSV::VERSION
	gem.date		= '2016-06-03'
	gem.authors		= ['Duckfloss']
	gem.email		= 'ben@bencjones.com'
	gem.homepage	= 'https://github.com/Duckfloss/formatcsv'
	gem.summary		= 'Reformat CSV files for other websites'
	gem.description	= 'This is for reformatting csv files for exporting to places.'
	gem.files = ["lib/formatcsv.rb", "lib/formatcsv/vendors.yml", "lib/formatcsv/version.rb"]
	gem.license		 = 'MIT'
end