module CoffeeShop
  class SessionController < CoffeeShop::Controller
    def handle(request)
      @request = request

      respond
    end

    def post
      email_address = param(:email_address)
      password = param(:password)
      
      @user = CoffeeShop::User.authenticate(email_address, password)

      render "session/post.html"
    end

    def delete
      session(:user_id, nil)

      render "session/delete.html"
    end
  end
end
