module CoffeeShop
  module AssetHelper
    def stylesheet(path, options = {})
      markup = "<link href=\"#{path}\""
      
      options.each do |key, value|
        markup += " #{key}=\"#{value}\""
      end

      markup + ">"
    end
  end
end
