module CoffeeShop
  module AssetHelper
    
    # NOTE: AssetHelper will generate HTML 5 markup only.
    
    def stylesheet(file, attributes = {})
      attributes = {
        rel: "stylesheet",
        href: CoffeeShop::Application.base + "/asset/#{file}"
      }.merge(attributes)

      open_tag(:link, attributes)
    end

    def javascript(file, attributes = {})
      attributes = {
        src: CoffeeShop::Application.base + "/asset/#{file}"
      }.merge(attributes)

      open_tag(:script, attributes) + close_tag(:script)
    end

    def attribute_string(attributes)
      markup = ""

      attributes.each do |key, value|
        markup += " #{key}=\"#{value}\""
      end

      markup
    end

    def open_tag(tag, attributes = {})
      "<#{tag.to_s}" + attribute_string(attributes) + ">"
    end

    def close_tag(tag)
      "</#{tag.to_s}>"
    end
  end
end
