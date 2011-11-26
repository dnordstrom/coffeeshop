require "digest/sha2"

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

  it "should set a new password salt" do
    user = user(password_salt: "OLD_SALT")
    user.new_salt!
    user.password_salt.should_not == "OLD_SALT"
  end

  it "should set a new password hash using password and salt" do
    user = user()
    user.new_salt!
    user.new_hash!("test")

    hash = Digest::SHA256.hexdigest("password=test&salt=#{user.password_salt}")
    user.password_hash.should == hash
  end
end