module CoffeeShop
  module AssetHelper
    
    # NOTE: AssetHelper will generate HTML 5 markup only.
    
    def stylesheet(path, attributes = {})
      default_attributes = {
        rel: "stylesheet",
        href: path
      }.merge!(attributes)

      open_tag("link", attributes)
    end

    def javascript(path, attributes = {})
      default_attributes = {
        src: path
      }.merge!(attributes)

      open_tag("script", attributes) + close_tag(:script)
    end

    def attributes(attributes)
      markup = ""

      options.each do |key, value|
        markup += " #{key}=\"#{value}\""
      end

      markup
    end

    def open_tag(tag, attributes = {})
      "<#{tag}" + attributes + ">"
    end

    def close_tag(tag)
      "</#{tag}>"
    end
  end
end
