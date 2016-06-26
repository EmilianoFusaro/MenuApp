class AddOrdineToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :ordine, :integer
  end
end
