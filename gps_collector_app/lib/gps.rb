# frozen_string_literal: true

##
# This class is the main module our GPS Collector.
#
# All web/http/rack logic should go through here for our app.
class GPS
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def response
    case @request.path
    when '/' then Rack::Response.new(render('AJ'))
    when '/other' then Rack::Response.new('Hello Other!')
    else Rack::Response.new('Not Found!', 404)
    end
  end

  def render(name)
    "Hello, #{name}!"
  end
end
