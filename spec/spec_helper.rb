module Factory
  def setting(values = {})
    default_values = {
      :setting  => "title",
      :value    => "CoffeeShop"
    }
    CoffeeShop::Setting.create!( default_values.merge(values) )
  end
  
  def product(values = {})
    default_values = {
      :title        => "Sample Product",
      :price        => 1000,
      :description  => "Sample description"
    }
    CoffeeShop::Product.create!( default_values.merge(values) )
  end
end

module SpecHelper
  def setup
    @app = Application.new
  end
end

module RequestHelper
  def get(path, data = {})
    env           = get_environment(
      "PATH_INFO"     => path,
      "QUERY_STRING"  => parse(data)
    )
    
    @app.call(env)
  end
  
  def post(path, data = {})    
    env           = get_environment(
      "REQUEST_METHOD"  => "POST",
      "PATH_INFO"       => path,
      "QUERY_STRING"    => parse(data)
    )
    
    @app.call(env)
  end
  
  def get_environment(values)
    default_values = {
      "REQUEST_METHOD"    => "GET",
      "PATH_INFO"         => "/",
      "SERVER_NAME"       => "localhost",
      "SERVER_PORT"       => "9292",
      "HTTP_HOST"         => "localhost",
      "QUERY_STRING"      => "",
      "rack.version"      => [1,1],
      "rack.url_scheme"   => "http",
      "rack.input"        => StringIO.new(""),
      "rack.errors"       => STDOUT,
      "rack.multithread"  => false,
      "rack.multiprocess" => false,
      "rack.run_once"     => true 
    }
    
    default_values.merge(values)
  end
  
  def parse(data)
    query_string = []
    data.each do |key, value|
      query_string.push CGI::escape(key) + "=" + CGI::escape(value)
    end
    query_string.join("&")
  end
  
  def status_of(response)
    response[0]
  end
  
  def format_of(response)
    content_type = response[1]["Content-Type"]
    
    format = :xml   if content_of(response).include?("<?xml") && content_type == "text/xml"
    format = :html  if content_of(response).include?("<html") && content_type == "text/html"
    format = :json  if content_of(response).include?("CSData = {}") && content_type == "text/javascript"
    
    format
  end
  
  def content_of(response)
    response[2].body.join
  end
end