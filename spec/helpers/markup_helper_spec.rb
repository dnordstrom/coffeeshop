require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include MarkupHelper

describe MarkupHelper do
  before :all do
    @base = CoffeeShop::Application.base

    setup
  end

  it "should output an anchor tag linking to index page" do
    markup = link_to("Home", :index)
    
    (
      markup.include?("href=\"#{@base}/page/index\"") &&
      markup.include?("title=\"Home\"") &&
      markup.include?(">Home</a>")
    ).should be_true
  end
end
