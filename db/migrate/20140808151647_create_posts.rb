class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.belongs_to :user
      t.belongs_to :flight
      t.boolean :satisfied
      t.string :text
    end
  end
end
