module CoffeeShop
  class Response < Rack::Response
    def initialize(view, binding)
      super('') # Pass empty argument to constructor to keep response body empty

      if Template.exists?(view)
        @status = (view == "page/404.html" ? 404 : 200)
        write Template.load(view, binding)
      else
        @status = 404
        write Template.load_404
      end
    end
  end
end