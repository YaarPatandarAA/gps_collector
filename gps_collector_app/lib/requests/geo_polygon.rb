# frozen_string_literal: true

require './lib/helpers/parse_polygon'

# Request method to GET GeoJSON point(s) within a geographical polygon.
# Function is able to take both Polygon with Holes or without Holes.
# Although only a Polygon with no Holes will work successfully, logic is only setup for
#
# == Parameters:
# params::
#   A GeoJSON Polygon is expected here.
#    {
#        "Poly":{
#            "type": "Polygon",
#            "coordinates": [
#                [
#                    [100.0, 0.0],
#                    [101.0, 0.0],
#                    [101.0, 1.0],
#                    [100.0, 1.0],
#                    [100.0, 0.0]
#                ]
#            ]
#        },
#        "Holes": false
#    }
#
# == Returns:
# Returns GeoJSON point(s) to the API caller, with a response status of 200
#
def geo_polygon(params)
  raise StandardError, 'GeoJSON Polygon needed' unless params['Poly']
  raise StandardError, 'Holes boolean parameter needed' if [nil, 0].include?(params['Holes'])
  raise StandardError, 'Holes parameter value needs to be boolean' unless [true, false].include? params['Holes']

  if params['Holes']
    parse_poly_holes(params['Poly'])
  else
    poly_query_string = parse_polygon_no_holes(params['Poly'])
    db_result_arr = geo_polygon_no_holes(poly_query_string)
  end

  Rack::Response.new(db_result_arr.to_json, 200, { 'Content-Type' => 'application/json' })
end

# Helper function to make the query to the DB to GET GeoJSON point(s) within a geographical polygon.
#
# == Parameters:
# poly_query_string::
#   A string representation of the Geo Polygon coordinates.
#
# == Returns:
# Returns database respone from which GeoJSON Point(s) are wthin the provided Geo Polygon
#
def geo_polygon_no_holes(poly_query_string)
  polygon = "POLYGON((#{poly_query_string}))"

  execute_sql_query("SELECT ST_AsGeoJSON(point) FROM geo_points WHERE ST_DWithin(point, ST_GeomFromText('#{polygon}'), 0)").map! do |x|
    JSON.parse(x[0])
  end
end
