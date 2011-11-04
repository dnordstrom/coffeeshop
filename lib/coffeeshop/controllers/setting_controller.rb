module CoffeeShop
  class SettingController < CoffeeShop::Controller
    include CoffeeShop::SettingHelper
    
    attr_accessor :setting
    
    def handle(request)
      @request = request
      setting  = @request.id
      
      return render_404 if setting.nil? or !CoffeeShop::Setting.exists?(setting)
      
      respond
    end

    def get
      @setting = CoffeeShop::Setting.first(:setting => @request.id)
    
      respond_to_html { render 'setting/get.html' }
      respond_to_xml  { render 'setting/get.xml' }
    end
    
    def post
      @setting = CoffeeShop::Setting.first(:setting => @request.id)
      @setting.value = @request.params['setting']['value']
      @setting.save
      
      respond_to_html { render 'setting/post.html' }
    end
  end
end