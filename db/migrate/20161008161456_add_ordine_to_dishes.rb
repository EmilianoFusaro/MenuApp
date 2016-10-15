class AddOrdineToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :ordine, :int
  end
end
