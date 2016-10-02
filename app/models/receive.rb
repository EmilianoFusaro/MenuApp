class Receive < ActiveRecord::Base
  validates_uniqueness_of :email, :scope => :tipo , :message=> "Attenzione! Hai Già Fatto Questa Richiesta."
  #validates_uniqueness_of :email, :message=> "Attenzione! Sei Già Registrato."
end
