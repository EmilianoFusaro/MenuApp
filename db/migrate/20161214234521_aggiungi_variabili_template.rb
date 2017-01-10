class AggiungiVariabiliTemplate < ActiveRecord::Migration
  def change
    add_column :templates, :tipo, :string
    add_column :templates, :sorgente, :text
    add_column :templates, :sezioni, :text
  end
end
