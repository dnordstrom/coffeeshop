module CoffeeShop
  module SessionHelper
    def session(key, value = nil)
      session = CoffeeShop::Application.session
      value.nil? ? session[key] : session[key] = value
    end
  end
end

