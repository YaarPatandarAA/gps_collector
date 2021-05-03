# frozen_string_literal: true

require 'rubygems'
require 'rack'
require 'minitest/autorun'
require './lib/gps'
require './lib/helpers/db_execs'

CLEAR_POINTS_TABLE = 'TRUNCATE geo_points;'

describe GPS do
  before do
    @request = Rack::MockRequest.new(GPS)
    execute_sql_query(CLEAR_POINTS_TABLE)
  end

  it 'returns a 404 response for unknown requests' do
    _(@request.get('/unknown').status).must_equal 404
  end

  it 'returns a 201 response for a success created Point' do
    _(@request.post(
      '/add_points',
      input: '[
        {
          "type": "Point",
          "coordinates": [100.0, 0.0]
        }
      ]'
    ).status).must_equal 201
  end

  it 'returns a 201 response for a success created GeoColl' do
    _(@request.post(
      '/add_points',
      input: '{
        "type":"GeometryCollection",
        "geometries":[
           {
              "type":"Point",
              "coordinates":[
                 0.0,
                 100.0
              ]
           }
        ]
     }'
    ).status).must_equal 201
  end

  it 'returns a Point(s) for geo_radius GET' do
    @request.post(
      '/add_points',
      input: '[
        {
          "type": "Point",
          "coordinates": [100.0, 0.0]
        }
      ]'
    )

    _(@request.get(
      '/geo_radius',
      input: '{
        "Point":{
            "type": "Point",
            "coordinates": [100.0, 0.0]
        },
        "Radius": 50.0,
        "Meters": true
    }'
    ).body).must_equal '[{"type":"Point","coordinates":[100,0]}]'
  end
end
