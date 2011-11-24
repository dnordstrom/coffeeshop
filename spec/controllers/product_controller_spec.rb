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
    product() # Creating product with default values specified in Factory
  end
  
  it "should respond with success status" do
    response = get "/product/1.xml", { 'sample' => 'test' }
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
  
  it "should change product title" do
    product(:id => 3)
    
    post "/product/3", { "title" => "New Title" }
    
    product = Product.get(3)
    title   = product.title
    product.destroy
    
    title.should == "New Title"
  end
  
  it "should chance product price" do
    product(:id => 3)
    
    post "/product/3", { "price" => "2000" }
    
    product = Product.get(3)
    price   = product.price
    product.destroy
    
    price.should == 2000
  end
  
  it "should change product description" do
    product(:id => 3)
    
    post "/product/3", { "description" => "New description" }
    
    product = Product.get(3)
    description = product.description
    product.destroy
    
    description.should == "New description"
  end
  
  it "should not change product ID" do
    post "/product/1", { "id" => "5" }
    
    Product.get(1).should_not be_nil
  end
  
  it "should respond to POST request with XML" do
    response = post "/product/1.xml"
    format_of(response).should == :xml
  end
  
  it "should include product ID as XML in POST response" do
    response = post "/product/1.xml"
    document = Nokogiri::XML( content_of(response) )
    
    product = document.at_css("product")
    id      = product.attribute("id").value.to_i
    
    id.should == 1
  end
  
  it "should include product title as XML in POST response" do
    response = post "/product/1.xml"
    document = Nokogiri::XML( content_of(response) )
    
    title = document.at_css("title").content
    title.should == 'Sample Product'
  end
  
  it "should include product price as XML in POST response" do
    response = post "/product/1.xml"
    document = Nokogiri::XML( content_of(response) )
    
    price = document.at_css("price").content.to_i
    price.should == 1000
  end
  
  it "should include product description as XML in POST response" do
    response = post "/product/1.xml"
    document = Nokogiri::XML( content_of(response) )
    
    description = document.at_css("description").content
    description.should == "Sample description"
  end
  
  it "should return product data in JSON format" do
    response = get "/product/1"
    
    format_of(response).should == :json
  end
end