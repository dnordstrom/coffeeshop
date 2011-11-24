module CoffeeShop
  class Order
    include DataMapper::Resource

    property :id, Serial
    property :status, String

    has 1, :billing_address
    has 1, :shipping_address
    has 1, :customer
    has n, :line_items
    belongs_to :shop
  end
end
