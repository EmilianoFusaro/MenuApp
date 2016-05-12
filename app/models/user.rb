class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #emiliano qui posso abilitare e disabilitare tutte le procedure di autenticazione
  devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable
         :rememberable, :trackable, :validatable

  has_one :profile
end
