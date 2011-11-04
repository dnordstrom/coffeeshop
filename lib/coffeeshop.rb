# Dependencies
require 'erb'
require 'dm-core'
require 'dm-sqlite-adapter'
require 'dm-migrations'
require 'dm-validations'
require 'rack'

# Helpers
require_relative 'coffeeshop/helpers/path_helper'
require_relative 'coffeeshop/helpers/setting_helper'

# Application components
require_relative 'coffeeshop/application'
require_relative 'coffeeshop/controller'

# Controllers
require_relative 'coffeeshop/controllers/page_controller'
require_relative 'coffeeshop/controllers/setting_controller'

# Models
require_relative 'coffeeshop/models/product'
require_relative 'coffeeshop/models/request'
require_relative 'coffeeshop/models/response'
require_relative 'coffeeshop/models/setting'
require_relative 'coffeeshop/models/template'