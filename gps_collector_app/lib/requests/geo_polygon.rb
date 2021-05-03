# frozen_string_literal: true

require './lib/helpers/parse_polygon'

# Polygons

# Coordinates of a Polygon are an array of linear ring (see
# Section 3.1.6) coordinate arrays.  The first element in the array
# represents the exterior ring.  Any subsequent elements represent
# interior rings (or holes).

# No holes:

# {
#   "type": "Polygon",
#   "coordinates": [
#     [
#       [100.0, 0.0],
#       [101.0, 0.0],
#       [101.0, 1.0],
#       [100.0, 1.0],
#       [100.0, 0.0]
#     ]
#   ]
# }

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

def geo_polygon_no_holes(poly_query_string)
  polygon = "POLYGON((#{poly_query_string}))"

  execute_sql_query("SELECT ST_AsGeoJSON(point) FROM geo_points WHERE ST_DWithin(point, ST_GeomFromText('#{polygon}'), 0)").map! do |x|
    JSON.parse(x[0])
  end
end
