class CreateAirlines < ActiveRecord::Migration
  def change
    create_table :airlines do |t|
      t.string :name
      t.string :fs_code

      t.timestamps
    end
    add_index :airlines, :fs_code, unique: true
  end
end
