module CoffeeShop
  class ProductController < CoffeeShop::Controller
    def handle(request)
      @request = request
      
      return render_404 if request.id.nil?
      
      respond
    end
    
    def get
      respond_to_xml  { render 'product/get.xml' }
    end
  end
end