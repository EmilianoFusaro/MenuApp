class Users::SessionsController < Devise::SessionsController

  #emiliano Questa è il login dell'utente che non deve essere bloccato
  #before_filter :configure_sign_in_params, only: [:new]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  #emiliano questa procedura di http autenticazione semplice è stata commentata non serve in fase di registrazione
  #protected
  #def configure_sign_in_params
  #  authenticate_or_request_with_http_basic("Home") do |username,password|
  #  username == "admin" && password == "340693"
  #  end
  #end

end
