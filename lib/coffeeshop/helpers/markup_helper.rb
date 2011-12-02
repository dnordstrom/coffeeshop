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
        '/' + 'page/' page.to_s +
        '">' + title + '</a>'
    end
  end
end
