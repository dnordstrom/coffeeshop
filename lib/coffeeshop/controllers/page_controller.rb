module CoffeeShop
  class PageController < CoffeeShop::Controller
    def handle(request)
      @request = request

      # Default to HTML content-type for this controller since
      # it does not deal with DB resources
      @request.format = "html"      
      
      return render "javascript/api.js" if request.js?
      return render 404 unless request.controller === self.class.to_s.split('::')[1]
      return render 'page/index.html' if request.id.nil?
      return render 404 unless CoffeeShop::Template.exists?("page/#{request.id}.html")
      
      respond
    end
    
    def get
      respond_to_html { render "page/#{@request.id}.html" }
    end
  end
end
