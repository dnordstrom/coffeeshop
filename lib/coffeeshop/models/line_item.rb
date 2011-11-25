module CoffeeShop
  class LineItem
    include DataMapper::Resource
   
    property :id, Serial
    property :price, Integer
    property :quantity, Integer

    belongs_to :product
    belongs_to :order
  end
end
