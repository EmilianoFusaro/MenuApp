class AddPrezzoColumnToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :prezzo, :decimal, :precision => 8, :scale => 2
  end
end
