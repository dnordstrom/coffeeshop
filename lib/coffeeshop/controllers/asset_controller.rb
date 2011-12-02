module CoffeeShop
  class AssetController < CoffeeShop::Controller
    def handle(request)
      @request = request

      respond
    end

    def get
      render "asset/#{@request.format}/#{@request.id}"
    end
  end
end
