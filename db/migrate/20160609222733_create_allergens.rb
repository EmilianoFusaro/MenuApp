class CreateAllergens < ActiveRecord::Migration
  def change
    create_table :allergens do |t|
      t.string :nome
      t.text :descrizione
      t.string :img
      t.string :img1
      t.string :img2

      t.timestamps null: false
    end
  end
end
