module Factory
  def setting(values)
    default_values = {
      :setting  => 'title',
      :value    => 'CoffeeShop'
    }
    CoffeeShop::Setting.create!( default_values.merge(values) )
  end
  
  def product(values)
    default_values = {
      :title        => 'Sample Product',
      :price        => 1000,
      :description  => 'Sample description'
    }
    CoffeeShop::Product.create!( default_values.merge(values) )
  end
end

module SpecHelper
  def setup
    app = Application.new
    app.load_environment
    app.configure_database
  end
end