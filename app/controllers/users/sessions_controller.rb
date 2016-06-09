class Users::SessionsController < Devise::SessionsController

  layout 'login', only: [:new]
  #emiliano Questa è il login dell'utente che non deve essere bloccato

  # GET /resource/sign_in
   def new
    super
    #anche questa istruzione mi permette di settare il layout
    #render :layout => 'testindex'
   end

  # POST /resource/sign_in
  # def create
  #   super
  #   puts "EMILIANO 2"
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

end
