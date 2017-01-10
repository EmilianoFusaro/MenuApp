class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :nome
      t.text :descrizione
      t.string :img
      t.integer :ordine
      t.text :variabile_a
      t.text :variabile_b

      t.timestamps null: false
    end
  end
end
