module CoffeeShop
  class LineItem
    include DataMapper::Resource
   
    property :price, Integer
    property :quantity, Integer

    belongs_to :product, :key => true
    belongs_to :order, :key => true
  end
end
