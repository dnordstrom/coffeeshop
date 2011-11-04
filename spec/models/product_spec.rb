require_relative '../../lib/coffeeshop'
require_relative '../spec_helper.rb'

include SpecHelper
include CoffeeShop
include Factory

describe Product do  
  before(:all) do
    setup
  end
  
  it "should require a title" do
    product = product(:title => '')
    product.should_not be_valid
  end
  
  it "should require a price" do
    product = product(:price => nil)
    product.should_not be_valid
  end
  
  it "should allow an empty description" do
    product = product(:description => '')
    product.should be_valid
  end
  
  it "should require numerical value for price" do
    product = product(:price => 'invalid value')
    product.should_not be_valid
  end
end