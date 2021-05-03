# frozen_string_literal: true

# Takes a GeoJSON point, takes out and returns the coordinates.
#
#   {
#      "type": "Point",
#      "coordinates": [100.0, 0.0]
#   }
#
# == Parameters:
# point_parm::
#  GeoJSON point is accepted, should follow the above json structure.
#
# == Returns:
# Returns a array of 1 coordinate from the GeoJSON point object.
#  [100.0, 0.0]
#
def parse_point(point_parm)
  raise StandardError, 'Not a point object' if point_parm['type'] != 'Point'

  point = point_parm['coordinates']
  raise StandardError, 'No coordinates' unless point

  point
end
