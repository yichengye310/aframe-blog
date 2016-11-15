class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :image
      t.string :url
      t.text :excerpt

      t.timestamps null: false
    end
  end
end
