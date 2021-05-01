# frozen_string_literal: true

require './lib/helpers/db_execs'
require './lib/requests/add_points'

CREATE_EXTENTION = 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS geo_points (id uuid DEFAULT uuid_generate_v1(), point geography(POINT), PRIMARY KEY (id));'
CLEAR_POINTS_TABLE = 'TRUNCATE geo_points;'

def init_db
  execute_sql_query(CREATE_EXTENTION)
  execute_sql_query(CREATE_TABLE)
  execute_sql_query(CLEAR_POINTS_TABLE)
end

def random_fill
  add_points(Array.new(100) do
    { 'type' => 'Point', 'coordinates' => [rand(-180...180), rand(-90...90)] }
  end)
end
