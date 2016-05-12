class HomeController < ApplicationController
  #emiliano altro modo per abilitare autenticazione semplice sul controller
  #http_basic_authenticate_with :name => "admin" , :password => "340693"

  def index
  end

  def vietato
    #reinderizzo ad una pagina statica in public
    #render :file => "public/401.html", :status => :unauthorized, :layout => false
  end


end
