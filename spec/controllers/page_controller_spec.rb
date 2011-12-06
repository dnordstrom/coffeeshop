require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include Factory
include RequestHelper

describe PageController do  
  before :all do
    setup
  end
  
  it "should output Javascript API" do
    response = get "/api.js"
    
    content_of(response).include?("/* CoffeeShop API").should be_true
  end

  context "when instance method exists with same name as requested page" do
    it "should call the instance method for page" do
      PageController.any_instance.should_receive(:products).and_return([])

      response = get "/page/products"
    end
  end
end
