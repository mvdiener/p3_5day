class CreateFlights < ActiveRecord::Migration
  def change
    create_table :flights do |t|
      t.belongs_to :airline
      t.belongs_to :arrival_airport
      t.belongs_to :departure_airport
      t.datetime :departure_scheduled
      t.datetime :departure_actual
      t.datetime :arrival_scheduled
      t.datetime :arrival_actual
    end
  end
end
