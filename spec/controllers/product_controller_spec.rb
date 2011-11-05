require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include Factory
include RequestHelper

describe ProductController do
  before :all do
    setup
    
    product(
      :id           => 1,
      :title        => 'Sample Product',
      :price        => 1000,
      :description  => 'Sample description'
    )
  end
  
  it "should respond with success status" do
    response = get "/product/1.xml"
    status_of(response).should == 200
  end
  
  it "should respond with page cannot be found status" do
    response = get "/product/invalid"
    status_of(response).should == 404
  end
  
  it "should respond with XML content and content-type" do
    response = get "/product/1.xml"
    format_of(response).should == :xml
  end
  
  it "should return product title in XML" do
    response = get "/product/1.xml"
    
    document = Nokogiri::XML( content_of(response) ) do |config|
      config.noblanks.noent
    end
    
    product = document.at_css("products product title").content
    product.should == 'Sample Product'
  end
end