class Mapper

  attr_reader :map, :headers

  def initialize(params)
    file = YAML.load(File.open("./lib/formatcsv/map/#{params[:format]}.yml"))
    source = {"u"=>"uniteu", "r"=>"rpro"}
    data_type = {"p"=>"products", "v"=>"variants"}
    @map = file["#{source[params[:source]]}_#{data_type[params[:data_type]]}"]
    @headers = file["headers"].split
  end

end