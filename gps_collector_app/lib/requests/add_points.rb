# frozen_string_literal: true

require './lib/helpers/db_execs'
require './lib/helpers/parse_point'

ADD_POINT_SQL = 'INSERT INTO geo_points (point) VALUES '

def add_points(params)
  points_array = params.is_a?(Array) ? (params.map! { |x| parse_point(x) }) : points_geom(params)
  points_array.map! { |x| "('POINT(#{x[0]} #{x[1]})')" }
  all_points = points_array.join(', ')

  add_points_query = "#{ADD_POINT_SQL} #{all_points};"

  execute_sql_query(add_points_query)

  Rack::Response.new('Success', 201)
end

def points_geom(geo_collection)
  raise StandardError, 'This is not a GeometryCollection nor a Points array' if geo_collection['type'] != 'GeometryCollection'

  geo_collection['geometries'].map! { |x| parse_point(x) }
end
