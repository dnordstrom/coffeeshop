module CoffeeShop
  module PathHelper
    def path(path, append = "")
      return CoffeeShop::Application.root  + append if path.to_sym === :root
      return CoffeeShop::Application.db    + append if path.to_sym === :db
      return CoffeeShop::Application.views + append if path.to_sym === :views
      return CoffeeShop::Application.base  + append if path.to_sym === :base
    end
    
    def path_to(resource)
      path(:base) + '/' + resource.class.name.downcase.split('::')[1] + '/' + resource.id.to_s
    end
    
    def path_to_page(page)
      path(:base) + '/page/' + page.to_s
    end
    
    def path_to_setting(setting)
      path(:base) + '/setting/' + setting.setting
    end
  end
end
