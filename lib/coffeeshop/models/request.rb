module CoffeeShop
  class Request < Rack::Request
    attr_accessor :controller
    attr_accessor :id
    attr_accessor :action
    attr_accessor :format
    
    def initialize(env)
      super(env)
      
      path = path_info.split('/')
      
      @controller  = (path[1] || 'page').capitalize + 'Controller'              # Name of controller class to be invoked
      @id          =  path[2]                                                   # ID of resource, if requested
      @action      =  path[3].nil? ? nil : (path[3].split('.')[0] || path[3])   # Specified action
      
      if !@id.nil? && @id.include?(".")
        strings = @id.split(".")        # Split string if format has been appended to ID in URL
        @id     = strings[0]            # ID of resource, if requested
        @format = strings[1]            # Requested format, defaults to HTML
      end
    end
    
    def put?
      http_method == 'PUT'
    end
    
    def delete?
      http_method == 'DELETE'
    end
    
    def http_method
      params['_method'].nil? ? false : params['_method'].upcase
    end
  end
end