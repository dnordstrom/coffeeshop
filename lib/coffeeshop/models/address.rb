module CoffeeShop
  class Address
    include DataMapper::Resource

    property :id, Serial
    property :first_name, String
    property :last_name, String
    property :address, String
    property :address_extra, String
    property :city, String
    property :state, String
    property :zip_code, String
    property :country, String
    property :phone_number, String
  end
end
