class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :nome
      t.text :descrizione
      t.string :categorie
      t.string :piatti
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
