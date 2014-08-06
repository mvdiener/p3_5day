class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.integer :airline_id
      t.datetime :departure_scheduled
      t.datetime :departure_actual
      t.datetime :arrival_scheduled
      t.datetime :arrival_actual
      t.string :departure_city
      t.string :arrival_city

      t.timestamps
    end
  end
end
