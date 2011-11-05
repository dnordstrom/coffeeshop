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
    product()
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
  
  it "should return product ID in XML" do
    response = get "/product/1.xml"
    document = Nokogiri::XML( content_of(response) )
    
    product = document.at_css("product")
    id      = product.attribute("id").value.to_i
    
    id.should == 1
  end
  
  it "should return product title in XML" do
    response = get "/product/1.xml"
    document = Nokogiri::XML( content_of(response) )
    
    title = document.at_css("title").content
    title.should == 'Sample Product'
  end
  
  it "should return product price in XML" do
    response = get "/product/1.xml"
    document = Nokogiri::XML( content_of(response) )
    
    price = document.at_css("price").content.to_i
    price.should == 1000
  end
  
  it "should return product description in XML" do
    response = get "/product/1.xml"
    document = Nokogiri::XML( content_of(response) )
    
    description = document.at_css("description").content
    description.should == "Sample description"
  end
  
  it "should return all products in XML" do
    response = get "/product/all.xml"
    document = Nokogiri::XML( content_of(response) )
    
    products = document.css("product")
    products.count.should == 2
  end
end