module CoffeeShop
  class Request < Rack::Request
    attr_accessor :controller
    attr_accessor :id
    attr_accessor :action
    attr_accessor :format
    attr_accessor :js
    
    def initialize(env)
      super(env) # Initialize Rack::Request
      
      self.js = true if path_info == "/api.js"
      path = path_info.split('/')
      
      # Controller class
      @controller = (path[1] || "page").capitalize + "Controller"

      # ID of resource
      @id =  path[2]

      # Specified action
      @action = path[3].nil? ? nil : (path[3].split(".")[0] || path[3])
      
      # Check if IS contains dot-separated request format
      if !@id.nil? && @id.include?(".")
        strings = @id.split(".")        # Split string if format has been appended to ID in URL
        @id     = strings[0]            # ID of resource, if requested
        @format = strings[1]            # Requested format, defaults to HTML
      else
        # Set format to HTML if undefined.
        @format = :html
      end
    end
    
    def put?
      http_method == "PUT"
    end
    
    def delete?
      http_method == "DELETE"
    end
    
    def http_method
      params['_method'].nil? ? false : params['_method'].upcase
    end
    
    def js?
      js
    end
  end
end
