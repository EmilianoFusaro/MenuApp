class AddTemplateIdColumnToMenu < ActiveRecord::Migration
  def change
    add_column :menus, :template_id, :integer
  end
end
