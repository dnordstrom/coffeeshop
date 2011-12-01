module CoffeeShop
  class AssetController
    def handle(request)
      @request = request

      respond
    end

    def get
      render "asset/#{@request.format}/#{@request.id}"
    end
  end
end
