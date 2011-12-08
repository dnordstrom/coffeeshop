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
      login_details = param(:session)
      email_address = login_data[:email]
      password = login_data[:password]
      
      @user = CoffeeShop::User.authenticate(email_address, password)
      session(:user_id, @user.id) unless @user.nil?

      render "session/post.html"
    end

    # DELETE request logs user out by destroying session
    def delete
      session(:user_id, nil)

      render "session/delete.html"
    end
  end
end
