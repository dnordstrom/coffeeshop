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

    # NOTE: Attributes argument specified submit button
    # attributes, not form attributes.
    def button_to(value, controller, method, attributes = {})
      form_attributes = {
        action: CoffeeShop::Application.base + "/#{controller.to_s}",                
        method: "post",
      }
      
      markup = open_tag(:form, form_attributes)
      markup += hidden_field(:_method, { value: method.to_s })
      markup += submit_button(value, attributes)
      markup += close_tag(:form)
    end

    def text_field(id, attributes = {})
      name = name_attribute_from(id)
      id = id_attribute_from(id)
      
      attributes = {
        type: "text",
        name: name,
        id: id
      }.merge(attributes)
      
      open_tag(:input, attributes)
    end

    def text_area(id, attributes = {})
      name = name_attribute_from(id)
      id = id_attribute_from(id)
      
      attributes = {
        name: name,
        id: id
      }.merge(attributes)
      
      open_tag(:textarea, attributes) + close_tag(:textarea)
    end

    def label(text, target, attributes = {})
      target = name_attribute_from(target)
      
      attributes = {
        :for => target
      }.merge(attributes)
      
      open_tag(:label, attributes) + text + close_tag(:label)
    end

    def hidden_field(id, attributes = {})
      name = name_attribute_from(id)
      id = id_attribute_from(id)
      
      attributes = {
        type: "hidden",
        name: name,
        id: id
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
        action = model.to_s
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

    def name_attribute_from(name)
      case name
      when Array
        name[0].to_s + "[#{name[1].to_s}]" if name.length === 2
      else
        name.to_s
      end
    end

    def id_attribute_from(id)
      case id
      when Array
        "#{id[0].to_s}_#{id[1].to_s}" if id.length === 2
      else
        id.to_s
      end
    end
  end
end
