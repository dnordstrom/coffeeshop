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
      @format      =  path[3].nil? ? 'html' : (path[3].split('.')[1] || 'html') # Requested format, defaults to HTML
    end
    
    def put?
      http_method == 'PUT'
    end
    
    def delete?
      http_method == 'DELETE'
    end
    
    def http_method
      return false if params['_method'].nil?
      params['_method'].upcase
    end
  end
end