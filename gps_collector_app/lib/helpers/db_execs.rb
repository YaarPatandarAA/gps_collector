# frozen_string_literal: true

require 'pg'

# Takes a SQL Query and runs it aginst a Postgres/PostGIS databse
# results from Query are then reutned back to where call was made.
#
# == Parameters:
# sql::
#   The SQL Query to be made, this should be a `:string` datatype. 
#   Addionally this could have $n number of fillable parameters.
#
# params::
#   These are the params that could be used to fill the previous SQL Query.
#
# == Returns:
# A string representing the response from the database.
#
# == Example:
#  execute_sql_query(
#    'SELECT ST_AsGeoJSON(point) FROM geo_points WHERE ST_Distance(point, ST_GeographyFromText($1)) <= $2',
#    [point, radius_meters]
#  )
def execute_sql_query(sql, params = [])
  begin
    conn = PG.connect(host: 'localhost', dbname: 'gps_collector', user: 'gps_collector', password: 'gps_collector')
    conn.set_notice_receiver do
      nil
    end
  rescue PG::ConnectionBad => e
    raise StandardError, "Conection to Postgres Database failed. #{e}"
  end

  result = conn.exec_params(sql, params)
  result.values
end
