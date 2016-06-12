class CreateIngredients < ActiveRecord::Migration
  def change
    create_table :ingredients do |t|
      t.string :nome
      t.text :descrizione
      t.string :img
      t.string :img1
      t.string :img2
      t.string :allergen_id

      t.timestamps null: false
    end
  end
end
