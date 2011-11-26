module CoffeeShop
  class User
    include DataMapper::Resource
    include NI::UserHelper

    property :id, Serial
    property :email_address, String, required: true, format: :email_address
    property :password_salt, String, required: true, length: 64
    property :password_hash, String, required: true, length: 64

    #def new_salt!(length = 64)
    #  @password_salt = new_salt(length)
    #end
  end
end
