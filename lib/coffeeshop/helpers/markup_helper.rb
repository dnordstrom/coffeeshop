module CoffeeShop
  module MarkupHelper
    def link_to(title, resource, attributes = {})
      href = CoffeeShop::Application.base

      case resource
      when Symbol
        href += "/page/#{resource.to_s}"
      when Object
        # Any object with an ID insance variable will be used
        # to construct the link to the object's REST URI.
        unless resource.id.nil?
          href += "/#{resource.class.to_s.split("::")[1].downcase}/#{resource.id}"
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
    
    # Helper method for method_missing ghost methods, e.g.
    # text_field, password_field etc.
    def field(id, attributes = {})
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
      
      open_tag(:form, attributes)
    end

    def end_form
      close_tag(:form)
    end
    
    # Uses instance_eval to run block in context of a Form object,
    # outputting name attributes as an array with same name as
    # model. E.g.
    #
    # f.text_field :price #=>
    #   <input type="text" id="product_price" name="product[price]">
    def form(model, method, attributes = {})
      if block_given?
        form = Form.new
        form.instance_eval do
          begin_form(model, method, attributes)
          yield
          end_form
        end
      end

      form.to_s
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

    def method_missing(method, *args, &block)
      if method.to_s =~ /^(.*)_field$/
        name = args[0] || ""
        attributes = { type: $1 }.merge(args[1] || {})
        return send :field, name, attributes
      end
      
      super
    end
  end
end
