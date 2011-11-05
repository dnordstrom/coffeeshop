module CoffeeShop
  class Response < Rack::Response
    def initialize(view, binding, header = {})
      if Template.exists?(view)
        @status = (view == "page/404.html" ? 404 : 200)
        super('', @status, header)
        
        write Template.load(view, binding)
      else
        @status = 404
        super('', @status, header)
        
        write Template.load_404
      end
    end
  end
end