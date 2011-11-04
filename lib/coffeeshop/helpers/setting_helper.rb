module CoffeeShop
  module SettingHelper
    def setting(*args)
      return get_setting(args[0])          if args.length === 1
      return set_setting(args[0], args[1]) if args.length === 2
    end

    def get_setting(setting)
      Setting.first(:setting => setting.to_s).value
    end

    def set_setting(setting, value)
      setting = Setting.first(:setting => setting.to_s)
      setting.value = value.to_s
      setting.save
    end
  end
end