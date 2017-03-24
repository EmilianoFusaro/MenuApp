class RemoveidTemplateFromMenu < ActiveRecord::Migration
  def change
    remove_column :menus, :id_template
  end
end
