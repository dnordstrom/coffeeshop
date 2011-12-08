require './lib/coffeeshop.rb'

#app = Rack::Session::Cookie.new(
#  CoffeeShop::Application.new,
#  key: "key",
#  domain: "localhost",
#  path: "/",
#  expire_after: 86400,
#  secret: "ldYmvEpfnDE83hbT4"
#)

#app = Rack::Builder.new {
#  use Rack::ShowExceptions
#  use CoffeeShop::Application
#}


use Rack::Session::Cookie, :key => 'rack.session',
                           :domain => 'foo.com',
                           :path => '/',
                           :expire_after => 2592000,
                           :secret => 'change_me'

run CoffeeShop::Application.new
