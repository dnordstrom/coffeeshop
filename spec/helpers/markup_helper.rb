require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include MarkupHelper

describe MarkupHelper do
  before :all do
    setup
  end

  it "should output an anchor tag linking to a page" do
    href = CoffeeShop::Application.base + "/page/index"
    title = "Home"

    link_to(title, :index).should ===
      '<a href="' + href + '" title="' + title + '">' + title + '</a>'
  end

  it "should output a button to POST Session.delete" do
    action = CoffeeShop::Application.base + "/session"
    value = "Log out"
    controller = :session
    method = :delete

    button_to(value, controller, method).should ===
      '<form action="' + action.to_s + '" method="post">' +
      '<input type="hidden" name="_method" id="_method" value="' + method.to_s + '">' +
      '<input type="submit" value="' + value + '">' +
      '</form>'
  end
end
