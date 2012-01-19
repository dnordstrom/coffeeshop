module CoffeeShop
  class UserController < CoffeeShop::Controller
    def handle(request)
      respond
    end

    def post
      user_details = param(:user)
      
      if user_details[:password] === user_details[:password_confirmation]
        password = user_details.delete("password")
        user_details.delete("password_confirmation")

        @user = User.new(user_details)
        @user.new_salt!
        @user.new_hash!(password)

        if @user.save
          @notice = "User successfully saved."
        else
          @notice = "User could not be saved."
        end

        respond_to :html do
          @users = User.all
          render "page/users.html"
        end
      end
    end
  end
end
