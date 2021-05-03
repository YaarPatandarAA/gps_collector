# frozen_string_literal: true

require 'pg'

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
