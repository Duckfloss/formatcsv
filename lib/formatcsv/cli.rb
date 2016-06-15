require 'formatcsv'
require 'optparse'
require 'pry'

module FormatCSV
	class CLI

		def self.run(args)
			options = Hash.new
			options[:file] = nil
			options[:source] = nil
			options[:data] = nil
			options[:target] = nil
			options[:verbose] = false

			parse_options = OptionParser.new do |opt|
				opt.banner = "Usage: formatcsv FILE [options]"
				opt.separator ""
				opt.separator "Options:"

				opt.on('-su', 'Sourcefile comes from UniteU') { |source| options.source = source }
				opt.on('-sr', 'Sourcefile comes from RPro') { |source| options.source = source }

				opt.on('-dp', 'Sourcefile contains product data') { |data| options.data = data }
				opt.on('-dv', 'Sourcefile contains variant data') { |data| options.data = data }

				opt.on('-t', '--target TARGET', 'Specify the target type: \'shopify\', \'google\', or \'dynalog\'') { |target| options.target = target }

				opt.on('-v', 'Run in chatty mode.') { options.verbose = true }

				opt
			end

			parse_options.parse!(args)
binding.pry
#			x = FormatCSV::Write.new

		end
	end

end
