class CreateDishes < ActiveRecord::Migration
  def change
    create_table :dishes do |t|
      t.string :nome
      t.text :descrizione
      t.text :lista_ingredienti
      t.string :img
      t.string :img1
      t.string :img2
      t.string :img3
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
