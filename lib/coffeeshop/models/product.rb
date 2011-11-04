module CoffeeShop
  class Product
    include DataMapper::Resource
    
    property :id,           Serial
    property :title,        String
    property :price,        Integer
    property :description,  Text
    
    validates_presence_of :title, :price
  end
end