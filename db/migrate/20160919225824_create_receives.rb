class CreateReceives < ActiveRecord::Migration
  def change
    create_table :receives do |t|
      t.string :tipo
      t.string :email
      t.string :nome
      t.string :oggetto
      t.text :messaggio

      t.timestamps null: false
    end
  end
end
