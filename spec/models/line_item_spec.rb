require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include Factory

describe LineItem do
  before :all do
    setup
  end

  it "should require a product ID" do
    line_item(:product_id => nil)
  end
end
