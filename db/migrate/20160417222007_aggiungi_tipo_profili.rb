class AggiungiTipoProfili < ActiveRecord::Migration
  def change
    add_column :profiles, :stampalistino, :boolean, default: false
    add_column :profiles, :stampalistino_data, :datetime
    add_column :profiles, :weblistino, :boolean, default: false
    add_column :profiles, :weblistino_data, :datetime
  end
end
