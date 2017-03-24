class AddIdTemplateColumnToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :id_template, :integer
  end
end
