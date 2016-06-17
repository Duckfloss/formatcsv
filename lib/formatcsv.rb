#require 'formatcsv/cli'
require 'pry'
require 'yaml'
require 'csv'
require './lib/formatcsv/shopifile.rb'

module FormatCSV

  class Formatter

    attr_reader :source_file, :destination_file, :products

    def initialize(file)
      @source_file = CSV.read(file, :headers=>true,:header_converters=>:symbol)
      i = 0
      while File.exist?("#{File.dirname(file)}/Shopify_export#{i}.csv") == true
        i += 1
      end
      @destination_file = File.open("#{File.dirname(file)}/Shopify_export#{i}.csv","w")
      @products = []
    end

    def inspect
    end

    def uniteu
      @source_file.each do |row|
        @products << Shopifile.new(row).process
      end
      @products
    end

    def rpro

    end

  end


end