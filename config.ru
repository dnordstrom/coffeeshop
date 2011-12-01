require './lib/coffeeshop.rb'

app = Rack::Session::Cookie.new(
  CoffeeShop::Application.new,
  key: "key",
  domain: "localhost",
  path: "/",
  expire_after: 86400,
  secret: "ldYmvEpfnDE83hbT4"
)

run app
