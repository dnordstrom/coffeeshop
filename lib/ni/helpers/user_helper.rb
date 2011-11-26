module NI
  module UserHelper
    def new_salt(length = 256)
      Array.new(length/2) { rand(256) }.pack('C*').unpack('H*').first
    end

    def new_salt!(length = 256)
      @password_salt = new_salt(length)
    end
  end
end
