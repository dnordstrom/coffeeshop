module CoffeeShop
  class Order
    include DataMapper::Resource

    property :id, Serial
    property :status, String
    
    belongs_to :billing_address, "CoffeeShop::Address",
      :parent_key => [ :id ],
      :child_key => [ :billing_address_id ]

    belongs_to :shipping_address, "CoffeeShop::Address",
      :parent_key => [ :id ],
      :child_key => [ :shipping_address_id ]

    #has 1, :user
    has n, :line_items
    #belongs_to :shop

    validates_presence_of :line_items, :status
  end
end
