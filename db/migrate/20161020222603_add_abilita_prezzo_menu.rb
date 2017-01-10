class AddAbilitaPrezzoMenu < ActiveRecord::Migration
  def change
    add_column :menus, :abilitaprezzo, :boolean, :default => false
    add_column :menus, :prezzo, :decimal, :precision => 8, :scale => 2
  end
end
