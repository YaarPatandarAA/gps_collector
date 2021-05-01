# frozen_string_literal: true

def parse_point(point_parm)
  raise StandardError, 'Not a point object' if point_parm['type'] != 'Point'

  point = point_parm['coordinates']
  raise StandardError, 'No coordinates' unless point

  point
end
