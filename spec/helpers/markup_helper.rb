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
end
