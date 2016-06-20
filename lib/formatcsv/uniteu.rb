  class UniteU < FormatCSV::Formatter

    def uniteu
      @source_file.each do |row|
        @products << Shopifile.new(row).process
      end
      @products
    end

  end
