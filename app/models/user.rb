class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  #emiliano qui posso abilitare e disabilitare tutte le procedure di autenticazione
  devise :database_authenticatable, :registerable,
         #:recoverable, :rememberable, :trackable, :validatable
         :rememberable, :trackable, :validatable

  has_one  :profile
  has_many :categories
  has_many :dishes
  has_many :ingredients
  has_many :menus
  has_many :media

  #validates_presence_of :email, :message=>"Email Errata!"
  #validates_presence_of :password, :message=>"Password Errata!"

  def Elimina_Utente()
    Category.delete_all(user_id: self.id)
    Dish.delete_all(user_id: self.id)
    Ingredient.delete_all(user_id: self.id)
    Medium.destroy_all(user_id: self.id)
    Menu.delete_all(user_id: self.id)
    Profile.destroy_all(user_id: self.id)
    self.destroy()
  end

  def saluta
    puts self.id
  end

end
