module CoffeeShop
  module MarkupHelper
    def link_to(title, resource)
      markup = ""

      case resource
      when Symbol
        markup = link_to_page(title, resource)
      end

      markup
    end

    def link_to_page(title, page)
      '<a href="' +
        CoffeeShop::Application.base +
        '/' + 'page/' + page.to_s +
        '" title="' + title + '">' + title + '</a>'
    end

    def button_to(value, controller, method)
      '<form action="' + CoffeeShop::Application.base + '/' + controller.to_s + '" method="post">' +
        '<input type="hidden" name="_method" id="_method" value="' + method.to_s + '">' +
        '<input type="submit" value="' + value + '">' +
        '</form>'
    end

    def text_field(name, attributes)
      markup =
        '<input type="text" name="' + name.to_s + '" id="' + name.to_s + '"'

      attributes.each do |key, value|
        markup += ' ' + key.to_s + '="' + value.to_s + '"'
      end
        
      markup + '>'
    end

    def begin_form(model, method, attributes)
      markup = '<form action="' +
        CoffeeShop::Application.base + '/' + model.to_s + '"' + ' method="post"'

      attributes.each do |key, value|
        markup += ' ' + key.to_s + '="' + value + '"'
      end

      markup + '>'
    end

    def end_form
      '</form>'
    end
  end
end
