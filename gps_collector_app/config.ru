# frozen_string_literal: true

require 'rack'

require './lib/gps'

use Rack::Reloader, 0

run GPS
