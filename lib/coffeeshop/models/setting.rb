module CoffeeShop
  class Setting
    include DataMapper::Resource

    property :id, Serial
    property :setting, String
    property :value, String
    
    class << self
      def get(setting)
        setting = Setting.first(:setting => setting)
        setting.value
      end
    
      def exists?(setting)
        Setting.first(:setting => setting)
      end
    end
  end
end
