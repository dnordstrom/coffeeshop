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
        '">' + title + '</a>'
    end

    def button_to(value, controller, method)
      '<form action="' + CoffeeShop::Application.base + '/' + controller.to_s + '" method="post">' +
        '<input type="hidden" name="_method" id="_method" value="' + method.to_s + '">' +
        '<input type="submit" value="' + value + '">' +
        '</form>'
    end
  end
end
