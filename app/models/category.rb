class Category < ActiveRecord::Base
  belongs_to :user
  validates :titolo, presence: { message: "Attenzione! la categoria non può essere vuota" }
  #validates :descrizione, presence: { message: "Attenzione! la descrizione non può essere vuota" }
end
