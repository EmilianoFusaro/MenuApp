class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :titolo
      t.text :descrizione
      t.string :foto
      t.string :user_id

      t.timestamps null: false
    end
  end
end
