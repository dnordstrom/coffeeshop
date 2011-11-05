require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include Factory

describe Setting do    
  before :all do
    setup
    
    @title = setting({ :setting => "title", :value => "CoffeeShop" })
  end
  
  it "gets the setting value" do
    setting = Setting.get("title")
    setting.should == "CoffeeShop"
  end
  
  it "checks if setting exists" do
    Setting.exists?("title").should be_true
  end
end