module CoffeeShop
  class SessionController < CoffeeShop::Controller
    def handle(request)
      @request = request

      # Change default format from JSON to HTML for this controller
      @request.format = "html"

      respond
    end
    
    # GET request renders login form
    def get
      render "session/get.html"
    end
    
    # POST request 
    def post
      email_address = param(:email_address)
      password = param(:password)
      
      @user = CoffeeShop::User.authenticate(email_address, password)

      render "session/post.html"
    end

    # DELETE request logs user out by destroying session
    def delete
      session(:user_id, nil)

      render "session/delete.html"
    end
  end
end
