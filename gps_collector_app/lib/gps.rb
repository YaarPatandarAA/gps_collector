# frozen_string_literal: true

Dir['./lib/requests/*.rb'].sort.each { |file| require file }

# Converts the object into textual markup given a specific `format`
# (defaults to `:html`)
#
# == Parameters:
# format::
#   A Symbol declaring the format to convert the object to. This
#   can be `:text` or `:html`.
#
# == Returns:
# A string representing the object in a specified
# format.
#
class GPS
  def self.call(env)
    new(env).response.finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  # Converts the object into textual markup given a specific `format`
  # (defaults to `:html`)
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
