# frozen_string_literal: true

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

def geo_polygon
  Rack::Response.new({ 'Key' => 'geo_polygon' }.to_json, 200, { 'Content-Type' => 'application/json' })
end
