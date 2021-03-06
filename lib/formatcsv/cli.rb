require 'yaml'
require 'csv'
require './lib/formatcsv'
require './lib/formatcsv/shopifile'
require './lib/formatcsv/uniteu'
require './lib/formatcsv/map/mapper'


module FormatCSV
	class CLI

  attr_reader :options

		def self.run(args)
      @options = parse(args)
      FormatCSV.run(@options)
    end

    private

    def self.parse(args)
    	options = Hash.new
			options[:source_file] = nil
			options[:target_file] = nil
			options[:source] = nil
			options[:data_type] = "p"
			options[:format] = "shopify"
			options[:verbose] = false

      # Iterate through command options destructively
      while args.length > 0

        # if -h
        # print help and exit
        if i = args.index { |a| a == "-h" }
          print_help
          exit 0

        # if -v
        # mark verbose
        elsif i = args.index { |a| a =~ /^-v/ }
          options[:verbose] = true
          args.delete_at(i)
          next

        # if -s
        # check source selector
        elsif i = args.index { |a| a =~ /^-s/ }
          source = args.delete_at(i)
          # if selector is next char, save
          if ["u","r"].include? source[2]
            source = source[2]
          # if selector is next in array
          elsif ["u","r"].include? args[i+1]
            source = args.delete_at[i+1]
          # if selector is not present, error and exit
          else
            puts "Please indicate whether source data is from (u)UniteU or (r)RPro"
            puts "Example: 'formatcsv <sourcefile> -su' if it's from UniteU"
            exit -1
          end
          options[:source] = source
          next

        # if -d
        # check data selector
        elsif i = args.index { |a| a =~ /^-d/ }
          data_type = args.delete_at(i)
          # if selector is next char, save
          if ["p","v"].include? data_type[2]
            data_type = data_type[2]
          # if selector is next in array
          elsif ["p","v"].include? args[i+1]
            data_type = args.delete_at[i+1]
          # if selector is not present, error and exit
          else
            puts "Please indicate whether source data type is (p)products or (v)variants"
            puts "Please indicate whether source data type is (p)products or (v)variants"
            puts "Example: 'formatcsv <sourcefile> -dp' if it's products"
            exit -1
          end
          options[:data_type] = data_type
          next

        # if -f
        # check for format
        elsif i = args.index { |a| a =~ /^-f/ }
          args.delete_at(i)
          options[:format] = args.delete_at(i)
          if !["shopify","dynalog","google"].include? options[:format].downcase
            puts "Please indicate how to format: Shopify, Dynalog, or Google Merchant"
            puts "Example: 'formatcsv <sourcefile> -f shopify'"
            exit -1
          end

        # if it's not a flag
        # check if it's a csv and if it exists?
        else
          file = args.shift
          if File.extname(file) == ".csv"
            if File.exist?(file)
              if options[:source_file].nil?
                options[:source_file] = file
              else
                options[:target_file] = file
              end
            else
              if options[:source_file].nil?
                puts "The file #{file} doesn't exist."
                exit -1
              else
                options[:target_file] = file
              end
            end
          else
            puts "We don't know what the heck this (#{file}) is. We only deal in .csv formatted files"
            exit -1
          end
        end
      end
      return options
    end
    
    def self.print_help
      puts "\n"
      puts "Command takes a csv file and converts data into a format that can"
      puts "be used by Dynalog, Google Merchant, or Shopify. You must specify a"
      puts "source file, source data type, and target data type. If you specify"
      puts "a target file this will merge product data with existing variant"
      puts "data or vise-versa."
      puts "\n"
      puts "Usage: formatcsv <sourcefile> <targetfile> [options]"
      puts "\n"
      puts "    <sourcefile>  [REQUIRED]\t\tMust be a csv."
      puts "    <targetfile>  [OPTIONAL]\t\tMust be a csv."
      puts "\n"
      puts "Options:"
      puts "    -s[ur]\t\tSource data come from (u)UniteU or (r)RPro"
      puts "    -d[pv]\t\tSource data is (p)Product or (v)Variant info"
      puts "    -f FORMAT\t\tHow to format data: (shopify, google, dynalog)"
      puts "    -v\t\t\tRun in chatty mode"
      puts "    -h\t\t\tPrint out this help info."
    end
	end
end