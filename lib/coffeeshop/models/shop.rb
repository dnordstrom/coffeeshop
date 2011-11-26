module CoffeeShop
  class Shop
    include DataMapper::Resource

    property :id, Serial
    property :domain, String, required: true
  end
end
