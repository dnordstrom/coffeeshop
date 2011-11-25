require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include Factory

describe Order do
  before :all do
    setup
  end

  it "should require at least one line item" do
    order().should_not be_valid
  end

  it "should require an order status" do
    order = order(
      :status => nil,
      :line_items => [ line_item() ]
    )
    order.should_not be_valid
  end
end
