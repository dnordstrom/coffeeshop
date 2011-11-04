module CoffeeShop
  class Controller
    include CoffeeShop::PathHelper

    attr_accessor :output

    def self.handle(request)
      controller = "#{request.path_info.split('/')[1]}"
      controller_class = controller.capitalize + 'Controller'

      unless CoffeeShop::Application.VALID_CONTROLLERS.include?(controller_class)
        controller_class = 'PageController'
      end

      controller = eval("CoffeeShop::#{controller_class}").new
      controller.handle(request)
    end

    def render(view)
      @output = CoffeeShop::Response.new(view, binding).finish
    end

    def part(view)
      CoffeeShop::Template.load("parts/#{view}", binding)
    end
    
    def render_404
      render 'page/404.html'
    end
    
    def respond
      post    if @request.post?
      get     if @request.get?
      put     if @request.put?
      delete  if @request.delete?
      
      @output
    end
    
    def respond_to_html(&block)
      block.call if @request.format.to_sym === :html
    end
    
    def respond_to_xml(&block)
      block.call if @request.format.to_sym === :xml
    end
  end
end