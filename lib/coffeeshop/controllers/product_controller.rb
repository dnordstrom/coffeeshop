module CoffeeShop
  class ProductController < CoffeeShop::Controller
    include PathHelper
    
    def handle(request)
      @request = request

      respond
    end
    
    def get
      @products = @request.id.nil? || @request.id == "all" ? CoffeeShop::Product.all : CoffeeShop::Product.all(:id => @request.id)
      
      @products.length > 0 ? render("product/get.#{@request.format.to_s}") : render(404)
    end
    
    def post
      return render 404 if @request.id.nil?
      
      @products = CoffeeShop::Product.all(:id => @request.id)
      @products.first.update(params)
      
      render "product/post.#{@request.format.to_s}"
    end
  end
end
