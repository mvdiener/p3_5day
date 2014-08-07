class CreateAirports < ActiveRecord::Migration
  def change
    create_table :airports do |t|
      t.string :name
      t.string :fs_code
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
