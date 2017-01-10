class ChangeCategoriePiattiInMenu < ActiveRecord::Migration
  def change
    #nome tabella,record,tipo dato
    change_column :menus, :categorie, :text
    change_column :menus, :piatti, :text
  end
end
