# frozen_string_literal: true

Dir['./lib/requests/*.rb'].sort.each { |file| require file }

# Class to initialize the Rack::Request for accepting calls
#
class GPS
  # Function will setup a new Rack::Request env.
  #
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  # Response function will route calls to appropriate methods
  #
  # @return [JSON] depending on the route, a JSON object will be returned. Otherwise a success message.
  def response
    body_read = @request.body.read
    params = JSON.parse(body_read) unless [nil, 0, ''].include? body_read

    case @request.path
    when '/add_points' then add_points(params)
    when '/geo_radius' then geo_radius(params)
    when '/geo_polygon' then geo_polygon(params)
    else Rack::Response.new('Not Found!', 404)
    end
  end
end
