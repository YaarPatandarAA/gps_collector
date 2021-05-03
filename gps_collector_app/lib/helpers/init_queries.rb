# frozen_string_literal: true

require './lib/helpers/db_execs'
require './lib/requests/add_points'

# This is a SQL Query to create a UUID extention if it does not exist.
CREATE_EXTENTION = 'CREATE EXTENSION IF NOT EXISTS "uuid-ossp";'
# This is a SQL Query to create the geo_points table if it does not exist. The table will consist of an ID and a POINT.
CREATE_TABLE = 'CREATE TABLE IF NOT EXISTS geo_points (id uuid DEFAULT uuid_generate_v1(), point geography(POINT), PRIMARY KEY (id));'
# This is a SQL Query to clear the Table form all data records.
CLEAR_POINTS_TABLE = 'TRUNCATE geo_points;'

# Simple function to call few queries on Databse, this will initialize a new database if not already ready.
#
def init_db
  execute_sql_query(CREATE_EXTENTION)
  execute_sql_query(CREATE_TABLE)
  execute_sql_query(CLEAR_POINTS_TABLE)
end

# Simple function to fill the Points table with random values.
#
def random_fill
  add_points(Array.new(100) do
    { 'type' => 'Point', 'coordinates' => [rand(-180...180), rand(-90...90)] }
  end)
end
