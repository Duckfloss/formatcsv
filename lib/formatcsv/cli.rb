require 'formatcsv'
require 'optparse'
require 'ostruct'
require 'pry'

module FormatCSV
	class CLI


		def self.run(args)
			options = OpenStruct.new
			options.file = nil
			options.source = nil
			options.target = nil
			options.verbose = false

			parse_options = OptionParser.new do |opt|
				opt.banner = "Usage: formatcsv [options]"
				opt.separator ""
				opt.separator "Options:"

				opt.on('-s', '--source SOURCE', 'Specify the source type: \'uu\' or \'rpro\'') { |source| options.source = source }

				opt.on('-t', '--target TARGET', 'Specify the target type: \'shopify\', \'google\', or \'dynalog\'') { |target| options.target = target }

				opt.on('-v', 'Run in chatty mode.') { options.verbose = true }

				opt
			end

			parse_options.parse!(args)
#binding.pry
			x = FormatCSV::Write.new

		end
	end

end
