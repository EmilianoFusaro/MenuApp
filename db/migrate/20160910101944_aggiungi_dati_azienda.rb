#rails generate migration AggiungiDatiAzienda
class AggiungiDatiAzienda < ActiveRecord::Migration
  def change
    add_column :profiles, :ragionesociale, :string
    add_column :profiles, :indirizzo, :string
    add_column :profiles, :telefono, :string
    add_column :profiles, :cellulare, :string
    add_column :profiles, :fax, :string
    add_column :profiles, :email, :string
    add_column :profiles, :sitointernet, :string
    add_column :profiles, :logo, :string
  end
end
