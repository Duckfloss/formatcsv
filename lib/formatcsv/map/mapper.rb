class Mapper

  attr_reader :map, :headers

  def initialize(params)
    file = YAML.load(File.open("./lib/formatcsv/#{params[:format]}.yml"))
    @map = file["#{params[:source]}_#{params[:data]}"]
    @headers = file["headers"]
  end

end