module CoffeeShop
  class ProductController < CoffeeShop::Controller
    include PathHelper
    def handle(request)
      @request = request
      
      respond
    end
    
    def get
      @products = @request.id.nil? || @request.id == "all" ? CoffeeShop::Product.all : CoffeeShop::Product.all(:id => @request.id)
      
      respond_to_xml { @products.length ? render("product/get.xml") : render(404) }
    end
  end
end