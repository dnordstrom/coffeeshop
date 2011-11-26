module NI
  module UserHelper
    def new_salt(length = 64)
      Array.new(length/2) { rand(256) }.pack('C*').unpack('H*').first
    end

    def new_salt!(length = 64)
      @password_salt = new_salt(length)
    end

    def new_hash(password)
      Digest::SHA256.hexdigest("password=#{password}&salt=#{@password_salt}")
    end

    def new_hash!(password)
      @password_hash = new_hash(password)
    end
  end
end
