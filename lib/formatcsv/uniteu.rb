class UniteU < FormatCSV::Formatter

  def parse

    case @format.downcase
      when "shopify"
        @source_file.each do |row|
          @products << Shopifile.new(row, {:source=>"uniteu", :data_type=>"products"}).process
        end
binding.pry
        if @merge == true
          merge(@products)
        else
          write(@products)
        end
      when "dynalog"
        @products = 'Dynalogger.new(row, {:source=>"uniteu", :data_type=>"products"}).process'
      when "google"
        @products = 'Googlefy.new(row, {:source=>"uniteu", :data_type=>"products"}).process'
      else
        @products = 'Something else'
    end
    @products
  end

  private

  def write(products)
    
  end

  def merge(products)
    
  end
end
