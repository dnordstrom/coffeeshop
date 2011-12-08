module CoffeeShop
  class User
    include DataMapper::Resource
    include CoffeeShop::UserHelper
    extend CoffeeShop::SessionHelper
    
    property :id, Serial
    property :email_address, String, required: true, format: :email_address,
                                     unique: true
    property :password_salt, String, required: true, length: 64
    property :password_hash, String, required: true, length: 64

    def self.authenticate(email_address, password)
      user = first(email_address: email_address)
      
      if user.nil?
        user = false
      else
        hash = user.new_hash(password)
        user = false unless user.password_hash === hash
      end
       
      user
    end
  end
end
