module CoffeeShop
  class ProductController < CoffeeShop::Controller
    include PathHelper
    def handle(request)
      @request = request
      
      return render_404 if request.id.nil?
      
      respond
    end
    
    def get
      @product = CoffeeShop::Product.get(1)
      
      respond_to_xml  { render 'product/get.xml' }
    end
  end
end