class Shopifile

  attr_accessor :data

  SHOPIFY = [
    "handle",
    "title",
    "body",
    "vendor",
    "type",
    "tags",
    "published",
    "option1 name",
    "option1 value",
    "option2 name",
    "option2 value",
    "option3 name",
    "option3 value",
    "variant sku",
    "variant inventory qty"
    "variant price",
    "variant barcode",
    "image src",
    "image alt text"
  ]

  def initialize
    @data = Hash.new
  end
  
  def product
    SHOPIFY.each do |head|
      @data[head] = nil
    end
  end


end
