class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :descrizione
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
