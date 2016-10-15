class AddListaAllergeniToDish < ActiveRecord::Migration
  def change
    add_column :dishes, :lista_allergeni, :string
  end
end
