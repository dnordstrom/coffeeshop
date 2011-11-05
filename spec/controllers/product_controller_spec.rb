require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include Factory
include RequestHelper

describe ProductController do
  before :all do
    setup
  end
  
  it "should respond with valid response" do
    response = get "/product/1.xml"
    status_of(response).should == 200
  end
  
  it "should respond with page cannot be found status" do
    response = get "product/invalid"
    status_of(response).should == 404
  end
end