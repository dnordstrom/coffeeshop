module CoffeeShop
  class Order
    include DataMapper::Resource

    property :id, Serial
    property :status, String, required: true
    
    belongs_to :billing_address, "CoffeeShop::Address",
      :parent_key => [ :id ],
      :child_key => [ :billing_address_id ]

    belongs_to :shipping_address, "CoffeeShop::Address",
      :parent_key => [ :id ],
      :child_key => [ :shipping_address_id ]

    has n, :line_items
    belongs_to :user
    belongs_to :shop
    
    validates_presence_of :line_items, :user, :shop
  end
end
