require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include Factory

describe Shop do
  before :all do
    setup
  end

  it "should require a domain" do
    shop(domain: nil).should_not be_valid
  end
end
