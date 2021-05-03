# frozen_string_literal: true

require './lib/helpers/db_execs'
require './lib/helpers/parse_point'

# Request method to GET GeoJSON point(s) within a radius around a point.
#
# == Parameters:
# params::
#   GeoJSON Point and integer radius in feet/meters.
#    {
#        "Point":{
#            "type": "Point",
#            "coordinates": [100.0, 0.0]
#        },
#        "Radius": 50.0,
#        "Meters": true
#    }
#
# == Returns:
# Returns GeoJSON point(s) to the API caller, with a response status of 200
#
def geo_radius(params)
  raise StandardError, 'GeoJSON point needed' unless params['Point']

  radius_meters = check_radius(params)
  point = parse_point(params['Point'])
  point = "POINT(#{point[0]} #{point[1]})"

  db_result_arr = execute_sql_query(
    'SELECT ST_AsGeoJSON(point) FROM geo_points WHERE ST_Distance(point, ST_GeographyFromText($1)) <= $2',
    [point, radius_meters]
  ).map! do |x|
    JSON.parse(x[0])
  end

  Rack::Response.new(db_result_arr.to_json, 200, { 'Content-Type' => 'application/json' })
end

# Helper method to check and confirm the radius params.
#
# == Parameters:
# params::
#   Full params from API call, will only need to check Radius and Meters.
#    {
#        "Point":{
#            "type": "Point",
#            "coordinates": [100.0, 0.0]
#        },
#        "Radius": 50.0,
#        "Meters": true
#    }
#
# == Returns:
# Returns the radius in Meters to the caller.
#
def check_radius(params)
  radius = params['Radius']
  radius_measure = params['Meters']
  radius_errors(radius, radius_measure)

  radius *= 0.3048 if radius_measure == false

  radius
end

# Helper method to through any errors if there is a discrepancy in the params.
#
# == Parameters:
# radius::
#   Radius value from params, should be a non-negative numeric value.
# 
# radius_measure::
#   Radius measurment type, true for meters false for feet.
# 
# == Returns:
# N/A. No Returns, just throws any errors that may arise from radius params.
#
def radius_errors(radius, radius_measure)
  raise StandardError, 'Radius parameter needed' if radius.nil?
  raise StandardError, 'Radius must be numeric' unless radius.is_a? Numeric
  raise StandardError, 'Radius must be non-negative' if radius.negative?

  raise StandardError, 'Meters boolean parameter needed' if [nil, 0].include?(radius_measure)
  raise StandardError, 'Meters parameter value needs to be boolean' unless [true, false].include? radius_measure
end
