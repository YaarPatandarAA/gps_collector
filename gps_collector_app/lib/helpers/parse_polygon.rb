# frozen_string_literal: true

# This function takes a Polygon object with no holes and has
# its coordinates taken out and joined into a string and returned.
#
# Polygon with no holes:
#    {
#        "type": "Polygon",
#        "coordinates": [
#            [
#                [100.0, 0.0],
#                [101.0, 0.0],
#                [101.0, 1.0],
#                [100.0, 1.0],
#                [100.0, 0.0]
#            ]
#        ]
#    }
#
# == Parameters:
# poly_parm::
#   A Polynomial object with no holes.
#
# == Returns:
# A string representing of the coordinates from the GeoJSON Polygram object.
#
def parse_polygon_no_holes(poly_parm)
  raise StandardError, 'Not a Poly object' if poly_parm['type'] != 'Polygon'

  corr_array = poly_parm['coordinates'][0]
  raise StandardError, 'No coordinates' unless corr_array

  corr_array.map! do |x|
    x.join(' ')
  end

  corr_array.join(',')
end

# This function should be used for Polygon with holes, but is not used.
#
def parse_poly_holes
  raise StandardError, 'Polygon with Holes not supported'
end
