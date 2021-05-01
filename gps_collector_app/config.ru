# frozen_string_literal: true

require 'rack'
require 'json'
require './lib/gps'
require './lib/helpers/init_queries'

use Rack::Reloader, 0

init_db
random_fill
run GPS
