class UniteU < FormatCSV::Formatter

  def parse
    case @format.downcase
      when "shopify"
        @source_file.each do |row|
          @products << Shopifile.new(row, {:source=>"uniteu", :type=>"products"}).process
        end
#        if @merge == true
          
      when "dynalog"
        @products = 'Dynalogger.new(row, {:source=>"uniteu", :type=>"products"}).process'
      when "google"
        @products = 'Googlefy.new(row, {:source=>"uniteu", :type=>"products"}).process'
      else
        @products = 'Something else'
    end
    @products
  end

  private

  def write
    
  end

  def merge(products)
    
  end
end
