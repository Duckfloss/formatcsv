class UniteU < FormatCSV::Formatter

  def parse

    case @format.downcase
      when "shopify"
        @source_file.each do |row|
          @products << Shopifile.new(row, {:source=>"uniteu", :data_type=>"products", :map=>@mapper.map}).process
        end
        if @merge == true
          merge_to_file(@products)
        else
          write_to_file(@products)
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

  def write_to_file(products)
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

  def merge_to_file(products)
    headers = @mapper.headers
    rows = Rows.new

    @target_file.each do |row|
      rows << row.to_hash
    end

    products.each do |product|
      this_row = rows.by_id(product["pf_id"])
      product.merge!(this_row) {|k,v1,v2| v2}
      
    end
binding.pry

  end


end

class Rows < Array
  # Get appropriate row by its pf_id
  def by_id(id)
    hash = Hash.new

    self.each do |row|
      if row["pf_id"] == id
        hash = row
      end
    end

    return hash
  end
end
