module CoffeeShop
  class AssetController < CoffeeShop::Controller
    def handle(request)
      @request = request

      respond
    end

    def get
      format = @request.format
      file = @request.id

      render "asset/#{format}/#{file}.#{format}"
    end
  end
end
