class Mapper

  attr_reader :map, :headers

  def initialize(params)
    file = YAML.load(File.open("./lib/formatcsv/map/#{params[:format]}.yml"))
    @map = file["#{params[:source]}_#{params[:data_type]}"]
    @headers = file["headers"]
  end

end