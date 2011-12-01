module CoffeeShop
  class PageController < CoffeeShop::Controller
    def handle(request)
      # Save request hash
      @request = request

      # Default to HTML content-type for this controller since
      # it does not deal with DB resources
      @request.format = "html"      
      
      # JavaScript API requested, render api.js.
      return render "javascript/api.js" if request.js?

      # Non-existing resource requested, render 404.html.
      return render 404 unless request.controller ===
        self.class.to_s.split('::')[1]

      # No page specified, render index.html.
      return render 'page/index.html' if request.id.nil?

      # Template does not exist, render 404.html.
      return render 404 unless CoffeeShop::Template.exists?("page/#{request.id}.html")
      
      # Calling requested HTTP method
      respond
    end
    
    def get
      respond_to_html { render "page/#{@request.id}.html" }
    end
  end
end
