# Dependencies
require "rubygems"
require "bundler/setup"
require "erb"
require "dm-core"
require "dm-sqlite-adapter"
require "dm-migrations"
require "dm-validations"
require "rack"
require "rack-datamapper-session"
require "nokogiri"
require "digest/sha2"

# Helpers
require_relative "coffeeshop/helpers/path_helper"
require_relative "coffeeshop/helpers/setting_helper"
require_relative "coffeeshop/helpers/session_helper"
require_relative "coffeeshop/helpers/user_helper"
require_relative "coffeeshop/helpers/asset_helper"
require_relative "coffeeshop/helpers/markup_helper"

# Application components
require_relative "coffeeshop/application"
require_relative "coffeeshop/controller"

# Controllers
require_relative "coffeeshop/controllers/page_controller"
require_relative "coffeeshop/controllers/setting_controller"
require_relative "coffeeshop/controllers/product_controller"
require_relative "coffeeshop/controllers/session_controller"
require_relative "coffeeshop/controllers/asset_controller"

# Models
require_relative "coffeeshop/models/product"
require_relative "coffeeshop/models/request"
require_relative "coffeeshop/models/response"
require_relative "coffeeshop/models/setting"
require_relative "coffeeshop/models/template"
require_relative "coffeeshop/models/order"
require_relative "coffeeshop/models/address"
require_relative "coffeeshop/models/line_item"
require_relative "coffeeshop/models/user"
require_relative "coffeeshop/models/shop"
