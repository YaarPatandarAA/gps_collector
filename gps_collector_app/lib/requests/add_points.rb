# frozen_string_literal: true

require './lib/helpers/db_execs'
require './lib/helpers/parse_point'

# This is a SQL Query to insert points into the geo_points table.
ADD_POINT_SQL = 'INSERT INTO geo_points (point) VALUES '

# Request method to add Geo Points to the database.
#
# == Parameters:
# params::
#   This is the Points parameter which will be added to the database.
#   Two types of values can be expected here.
#   * Array of GeoJSON Point objects
#   * Geometry collection
#
#  Array of GeoJSON Point objects
#  [
#      {
#          "type": "Point",
#          "coordinates": [100.0, 0.0]
#      },
#      ...
#  ]
#
#  Geometry collection
#  {
#    "type":"GeometryCollection",
#    "geometries":[
#        {
#          "type":"Point",
#          "coordinates":[
#              0.0,
#              100.0
#          ]
#        },
#        ...
#    ]
#  }
#
# == Returns:
# Returns a success message to the API caller, with a response status of 201
#
def add_points(params)
  points_array = params.is_a?(Array) ? (params.map! { |x| parse_point(x) }) : points_geom(params)
  points_array.map! { |x| "('POINT(#{x[0]} #{x[1]})')" }
  all_points = points_array.join(', ')

  add_points_query = "#{ADD_POINT_SQL} #{all_points};"

  execute_sql_query(add_points_query)

  Rack::Response.new('Success', 201)
end

# Helper method to help parse coordinates from a GeoCollection.
#
# == Parameters:
# geo_collection::
#  A Geometry collection object is expected here.
#   {
#     "type":"GeometryCollection",
#     "geometries":[
#         {
#           "type":"Point",
#           "coordinates":[
#               0.0,
#               100.0
#           ]
#         },
#         ...
#     ]
#   }
#
# == Returns:
# Returns an array of coordinates.
#
def points_geom(geo_collection)
  raise StandardError, 'This is not a GeometryCollection nor a Points array' if geo_collection['type'] != 'GeometryCollection'

  geo_collection['geometries'].map! { |x| parse_point(x) }
end
