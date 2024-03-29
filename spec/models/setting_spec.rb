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
  
  it "should get the setting value" do
    setting = Setting.get("title")
    setting.should == "CoffeeShop"
  end
  
  it "should check if setting exists" do
    Setting.exists?("title").should be_true
  end
  
  it "should set the setting" do
    setting = Setting.first(:setting => "title")
    setting.value = "New Title"
    setting.save
    
    Setting.get("title").should == "New Title"
  end
end