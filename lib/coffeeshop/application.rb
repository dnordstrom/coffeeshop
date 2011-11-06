module CoffeeShop
  class Application
    include CoffeeShop::PathHelper

    class << self
      def root
        @@root
      end

      def root=(path)
        @@root = path
      end

      def db
        @@db
      end

      def db=(path)
        @@db = path
      end

      def views
        @@views
      end

      def views=(path)
        @@views = path
      end
      
      def base
        @@base
      end
      
      def base=(path)
        @@base = path
      end

      # Controllers that are allowed to be programmatically created
      # when handling incoming requests.
      def VALID_CONTROLLERS
        [
          'PageController',
          'SettingController',
          'ProductController'
        ]
      end
    end

    def initialize
      load_environment
      configure_database
    end

    # Gathers commonly used environment information, such as paths
    # and the appropriate database file.
    def load_environment
      @@root  = File.join(File.dirname(__FILE__), '..', '..')
      @@env   = (ENV['RACK_ENV'] ? ENV['RACK_ENV'].to_sym : :development)
      @@views = File.join(@@root, 'lib', 'coffeeshop', 'views')
      @@db    = File.join(@@root, 'db', "#{@@env}.sqlite")
    end

    # Sets up connection to the database, creating the database file
    # if it does not exist. Recreates it when in test environment.
    def configure_database
      DataMapper::Logger.new(STDOUT, :debug) if @@env === :development
      DataMapper.setup(:default, "sqlite://#{path(:db)}")

      create_database if @@env == :test || !File.exist?( path(:db) )
    end

    def create_database
      DataMapper.auto_migrate!
    end

    # Rack application entry point.
    def call(env)
      @@base = 'http://' + env['HTTP_HOST']
      
      CoffeeShop::Controller.handle( CoffeeShop::Request.new(env) )
    end
  end
end