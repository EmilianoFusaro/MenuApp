class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

   #protect_from_forgery with: :exception
   protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' } #aggiunto emiliano

  #emiliano aggiunto per personalizzare il processo di registrazione con altri campi
  before_action :configure_permitted_parameters, if: :devise_controller?
  #prima di qualsiasi azione forza il login
  #before_action :authenticate_user!

  before_action :controlla_pacchetti, only: [:profiles] #specifica su quali controller


  protected

  # def page_not_found
  #     respond_to do |format|
  #       format.html { render template: 'errors/not_found_error', layout: 'layouts/application', status: 404 }
  #       format.all  { render nothing: true, status: 404 }
  #     end
  # end

  def configure_permitted_parameters
    #emiliano aggiunta di campi nelle varie fasi del controller
    #devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #devise_parameter_sanitizer.permit(:account_update, keys: [:name])

    #devise_parameter_sanitizer.for(:sign_up) << :name
    #devise_parameter_sanitizer.for(:account_update) << :name
  end

  #reindirizza ad una pagina specifica dopo il login
  def after_sign_in_path_for(resource)
    detail_profiles_path
  end


  def controlla_pacchetti
    #debugger
    #puts "ECCOMI"
    #logger.debug "Emiliano Fusaro"
    #byebug
    if current_user
      if current_user.profile.nil? == false
        if current_user.profile.stampalistino==true && current_user.profile.stampalistino_data < DateTime.now
          current_user.profile.stampalistino = false
          current_user.stampalistino.save
          puts "Disattivo Stampa Listino"
        end
        if current_user.profile.weblistino==true && current_user.profile.weblistino_data < DateTime.now
          current_user.profile.weblistino = false
          current_user.profile.save
          puts "Disattivo Web Listino"
        end
      end
    end

  end

end
