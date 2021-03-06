module FormatCSV

  def self.run(options)
    if options[:source] == "u"
      $x = UniteU.new(options).parse
    elsif options[:source] == "r"
      $x = "RPro.new(options)"
    end
  end

  class Formatter
    attr_reader :source_file, :target_file, :verbose, :source, :data_type, :format, :products, :merge

    def initialize(options)
      @source_file = CSV.read(encode(options[:source_file]),:headers=>true,:header_converters=>:symbol)

      # Get target file
      @target_file = get_target_file({:source_file => options[:source_file], :target_file => options[:target_file]})

      # init empty products array
      @products = []

      @source = options[:source]
      @data_type = options[:data_type]
      @format = options[:format]
      @verbose = options[:verbose]
      @mapper = Mapper.new({:source=>@source, :data_type=>@data_type, :format=>@format})
    end

    def inspect
    end

    def get_target_file(params)
      # If target_file is specified
      if !params[:target_file].nil?
        # If it doesn't contain a directory
        if File.dirname(params[:target_file]) == "."
          # put it in source_file base directory
          target_file_name = "#{File.dirname(File.absolute_path(params[:source_file]))}/#{params[:target_file]}"
        else
          target_file_name = File.absolute_path(params[:target_file])
        end
        # then check if the file exists
        if File.exist?(target_file_name)
          # mark @merge true and open existing file
          @merge = true
          @target_data = CSV.read(encode(target_file_name), :headers=>:true, :write_headers=>true, :skip_blanks=>true)
          target_file = CSV.open(target_file_name, "w")
        else
          # otherwise mark @merge false and create new file
          @merge = false
          target_file = CSV.open(target_file_name, "w")
        end
      else
        # if target_file is NOT specified
        # get directory of source file
        path = File.dirname(File.absolute_path(params[:source_file]))
        i = 1
        target_file = "#{path}/#{File.basename(params[:source_file],'.csv')}#{i}.csv"
        while File.exist?(target_file) == true
          i += 1
          target_file = "#{path}/#{File.basename(params[:source_file],'.csv')}#{i}.csv"
        end
        target_file = CSV.open(target_file, "w")
      end
      return target_file
    end

    def encode(file)
      begin
        encoded_file = File.open(file, "r", {:encoding => "UTF-8"})
      rescue
        encoded_file = File.open(file, "r", {:encoding => "Windows-1252:UTF-8"})
      end
      return encoded_file
    end
  end
end