class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :airline_id
      t.integer :departure_airport_id
      t.integer :arrival_airport_id
      t.integer :fs_code
      t.string :flight_number
      t.datetime :departure_scheduled
      t.datetime :departure_actual
      t.datetime :arrival_scheduled
      t.datetime :arrival_actual

      t.timestamps
    end
  end
end
