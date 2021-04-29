require 'rubygems'
require 'rack'
require 'minitest/autorun'
require './lib/gps'

describe GPS do 
  before do
    @request = Rack::MockRequest.new(GPS)
  end

  it 'returns a 404 response for unknown requests' do
    _(@request.get('/unknown').status).must_equal 404
  end

  it '/ displays Hello, AJ! by default' do
    _(@request.get('/').body).must_include 'Hello, AJ!'
  end
end