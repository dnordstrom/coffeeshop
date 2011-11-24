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
    order(:line_items => nil).should_not be_valid
  end
end
