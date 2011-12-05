module CoffeeShop
  module MarkupHelper
    def link_to(title, resource, attributes = {})
      href = CoffeeShop::Application.base

      case resource
      when Symbol
        href += "/page/#{resource.to_s}"
      when Class
        if resource.is_a? CoffeeShop::Model
          href += "/#{resource.class.downcase}/#{resource.id}"
        end
      end

      attributes = {
        href: href,
        title: title
      }.merge(attributes)
      
      markup = open_tag(:a, attributes)
      markup += title
      markup += close_tag(:a)
    end

    def button_to(value, controller, method)
      form_attributes = {
        action: CoffeeShop::Application.base + "/#{controller.to_s}",                
        method: "post",
      }
      
      markup = open_tag(:form, form_attributes)
      markup += hidden_field(:_method, { value: method.to_s })
      markup += submit_button(value)
      markup += close_tag(:form)
    end

    def text_field(name, attributes = {})
      attributes = {
        type: "text",
        name: name.to_s,
        id: name.to_s
      }.merge(attributes)
      
      open_tag(:input, attributes)
    end

    def hidden_field(name, attributes = {})
      aatributes = {
        type: "text",
        name: name.to_s,
        id: name.to_s
      }.merge(attributes)

      open_tag(:input, attributes)
    end

    def submit_button(value, attributes = {})
      attributes = {
        type: "submit",
        value: value
      }.merge(attributes)

      open_tag(:input, attributes)
    end

    def begin_form(model, method, attributes = {})
      # Accepts both object and symbol argument for model.
      # "case model" will check the type of the model argument.
      case model
      when Symbol
        action = mode.to_s
      when Class
        action = model.class.downcase
      end

      attributes = {
        method: "post",
        action: CoffeeShop::Application.base + "/#{action}"
      }.merge(attributes)
      
      open_tag(:form, attributes) +
        close_tag(:form)
    end

    def end_form
      close_tag(:form)
    end

    def open_tag(tag, attributes = {})
      markup = "<#{tag.to_s}"
      markup += format_attributes(attributes) if attributes.length > 0
      markup += ">"
    end

    def format_attributes(attributes)
      markup = ""

      attributes.each do |key, value|
        markup += " #{key.to_s}=\"#{value}\""
      end

      markup
    end

    def close_tag(tag)
      "</#{tag.to_s}>"
    end
  end
end
