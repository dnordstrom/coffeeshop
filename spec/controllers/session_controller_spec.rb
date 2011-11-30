require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SessionHelper
include SpecHelper
include RequestHelper
include Factory

describe SessionController do
  before :all do
    setup

    @user = user(email_address: "abc@de.com")
    @user.new_salt!
    @user.new_hash!("test")
    @user.save
  end

  it "should authenticate user" do
    post "/session", {
      email_address: "abc@de.com",
      password: "test"
    }
    
    session(:user_id).should === @user.id
  end

  it "should log user out by deleting :user_id session" do
    post "/session", { _method: "delete" }

    session(:user_id).should be_nil
  end
end
