class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.integer :flight_id
      t.boolean :satisfaction
      t.text :text

      t.timestamps
    end
  end
end
