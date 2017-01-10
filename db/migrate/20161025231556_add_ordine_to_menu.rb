class AddOrdineToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :ordine, :integer
  end
end
