require './lib/coffeeshop.rb'

app = Rack::Session::DataMapper.new(
  CoffeeShop::Application.new,
  domain: "localhost",
  expire_after: 86400
)

run app
