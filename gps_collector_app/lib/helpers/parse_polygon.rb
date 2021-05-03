# frozen_string_literal: true

def parse_polygon_no_holes(poly_parm)
  raise StandardError, 'Not a Poly object' if poly_parm['type'] != 'Polygon'

  corr_array = poly_parm['coordinates'][0]
  raise StandardError, 'No coordinates' unless corr_array

  corr_array.map! do |x|
    x.join(' ')
  end

  corr_array.join(',')
end

def parse_poly_holes
  raise StandardError, 'Polygon with Holes not supported'
end
