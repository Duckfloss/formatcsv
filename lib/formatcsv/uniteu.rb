class UniteU < FormatCSV::Formatter

  def parse

    case @format.downcase
      when "shopify"
        @source_file.each do |row|
          @products << Shopifile.new(row, {:source=>"uniteu", :data_type=>"products", :map=>@mapper.map}).process
        end
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
    @target_file << headers = @mapper.headers
    products.each do |product|
      row = []
      headers.each do |header|
        row << product[header]
      end
      @target_file << row
    end
    @target_file.close
  end

  def merge(products)
    
  end
end
