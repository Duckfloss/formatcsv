#require 'formatcsv/cli'
require 'pry'
require 'yaml'
require 'csv'

module FormatCSV

	class From

		VENDORS = YAML.load(File.open("./formatcsv/vendors.yml"))

		def initialize(source_file)
			@source_file = CSV.read(source_file, :headers=>true,:header_converters=>:symbol)
			@destination_file = "#{File.dirname(file)}/#{File.basename(file,'.csv')}_toShopify.csv"
		end

		def Uniteu
			
		end

		def Rpro

		end

	end

	class Write
		def now
#binding.pry
			"It works"
		end
	end
end