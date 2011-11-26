require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include Factory

describe User do
  before :all do
    setup
  end

  it "should require an email address" do
    user(email_address: nil).should_not be_valid
  end

  it "should require a password salt" do
    user(password_salt: nil).should_not be_valid
  end

  it "should generate a new 256-bit password salt" do
    print user().new_salt!.inspect
  end
end
