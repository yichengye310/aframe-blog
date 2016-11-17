class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :url
      t.string :title
      t.text :image
      t.text :body
      t.text :description

      t.timestamps null: false
    end
  end
end
