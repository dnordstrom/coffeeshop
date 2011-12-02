require_relative "../../lib/coffeeshop"
require_relative "../spec_helper"

include CoffeeShop
include SpecHelper
include AssetHelper

describe AssetHelper do
  before :all do
    setup
  end

  it "should output a stylesheet link tag" do
    file = "application.css"
    href = CoffeeShop::Application.base + "/asset/#{file}"

    stylesheet("application.css").should ===
      '<link rel="stylesheet" href="' + href + '">'
  end

  it "should output a JavaScript script tag" do
    file = "application.js"
    src = CoffeeShop::Application.base + "/asset/#{file}"

    javascript("application.js").should ===
      '<script src="' + src + '"></script>'
  end
end
