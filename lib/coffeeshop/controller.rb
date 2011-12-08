module CoffeeShop
  class Controller
    include CoffeeShop::PathHelper
    include CoffeeShop::AssetHelper
    include CoffeeShop::MarkupHelper

    attr_accessor :output
    attr_accessor :request

    # Creates the appropriate controller and calls its handle() method
    # with the request variable as an argument.
    def self.handle(request)
      controller = request.path_info.split('/')[1]
      
      # Empty and "api.js" requests are handled by PageController.
      if controller.nil? || controller == "api.js"
        controller = "Page"
      else
        controller.capitalize!
      end

      controller += "Controller"     
      controller = CoffeeShop.const_get(controller).new
      controller.request = request

      controller.handle(request)
    end
    
    # Creates a Response object from the specified view and writes it
    # to @output, overwriting any existing output buffer.
    #
    # The @output variable contains the response that is returned
    # at the end of the request.
    def render(view)
      view = "page/404.html" if view == 404
      
      # Set content type based on requested format.
      if @request.format.nil?
        # Default to HTML content-type if request format isn't specified.
        # This should never occur, as Request sets a default format.
        content_type = "text/html"
      else
        content_type = (@request.format.to_sym === :json) ?
          "text/javascript" : "text/#{@request.format}"
      end
      
      @output = CoffeeShop::Response.new(view, binding, { 'Content-Type' => content_type }).finish
    end
    
    # Returns partial view, for outputting the content of a template
    # into another view.
    def part(view)
      CoffeeShop::Template.load("parts/#{view}", binding)
    end
    
    # Calls the appropriate method for responding to the request.
    def respond
      post    if @request.post?
      get     if @request.get?
      put     if @request.put?
      delete  if @request.delete?
      
      @output
    end
    
    # NOTE: Legacy code; now using respond_to :format
    #
    # Calls the block argument only if requested format is HTML, specifying
    # how to respond to HTML requests.
    def respond_to_html(&block)
      if @request.format.nil? || @request.format.to_sym === :html
        block.call
      else
        render 404
      end
    end
    
    # NOTE: Legacy code; now using respond_to :format
    #
    # Calls the block argument only if requested format is XML, specifying
    # how to respond to XML requests.
    def respond_to_xml(&block)
      if !@request.format.nil? && @request.format.to_sym === :xml
        block.call
      else
        render 404
      end
    end
    
    # NOTE: Legacy code; now using respond_to :format
    #
    # Calls the block argument only if requested format is JSON, specifying
    # how to respond to JSON requests.
    def respond_to_json(&block)
      if !@request.format.nil? && @request.format.to_sym === :json
        block.call
      else
        render 404
      end
    end

    def respond_to(format)
      if block_given?
        yield if @request.format.to_sym === format.to_sym
      end
    end

    def redirect_to(*args)
      # Respond with 302 Redirect status     
    end
    
    # Shortcut for the @request.params variable containing request data
    def params
      @request.params
    end

    # Shortcut to specific request param
    def param(key)
      @request.params[key.to_s]
    end
  end
end
