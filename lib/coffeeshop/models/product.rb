module CoffeeShop
  class Product
    include DataMapper::Resource
    
    property :id,           Serial
    property :title,        String
    property :price,        Integer
    property :description,  Text
    
    validates_presence_of :title, :price
    
    def to_json
      <<-eos
        {
          id: #{id},
          title: "#{title}",
          price: #{price},
          description: "#{description}"
        }
      eos
    end
  end
end