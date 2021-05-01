# frozen_string_literal: true

Dir['./lib/requests/*.rb'].sort.each { |file| require file }

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
    params = JSON.parse(@request.body.read)

    case @request.path
    when '/add_points' then add_points(params)
    when '/geo_radius' then geo_radius(params)
    when '/geo_polygon' then geo_polygon(params)
    else Rack::Response.new('Not Found!', 404)
    end
  end
end