require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include AssetHelper
include RequestHelper

describe AssetController do
  before :all do
    setup
  end

  it "should respond with application.css file" do
    response = get "/asset/application.css"
    
    content_of(response).include?("body {").should be_true
  end
end
