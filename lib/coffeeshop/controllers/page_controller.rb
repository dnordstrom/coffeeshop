module CoffeeShop
  class PageController < CoffeeShop::Controller
    # Creates hooks for running code before loading
    # specific pages.
    def self.before(page, &block)
      method = page.to_s.gsub('/', '_')

      define_method method.to_sym do
        instance_eval &block
      end
    end

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
      
      # If method exists with same name as requested
      # page, call it. This way we can set up instance
      # variables for specific pages.
      send(@request.id) if !@request.id.nil? && respond_to?(@request.id)

      # Calling requested HTTP method
      respond
    end
    
    # Responds to GET /page/* requests.
    def get
      respond_to_html { render "page/#{@request.id}.html" }
    end

    # Before loading products.html.erb.
    before :products do
      @products = Product.all
    end

    # Before loading users.html.erb.
    before :users do
      @users = User.all
    end
  end
end
