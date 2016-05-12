class Users::RegistrationsController < Devise::RegistrationsController

  #emiliano attivato blocco per non far registrare nessuno autonomamente
  before_filter :configure_sign_up_params, only: [:new]
  #before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  #def create
  #   #@user = User.new(params[:user][:name],params[:user][:email], params[:user][:password])
  #   #@user = User.new(params[:user][:name],params[:user][:email], params[:user][:password])
  #   #@user = User.new(user_params)
  #   @user = User.new(email: params[:user][:email], password: params[:user][:password], password_confirmation: params[:user][:password_confirmation])
  #   @profilo = Profile.create(:tipo => "utente")
  #   @user.profile = @profilo
  #   @user.save
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  #def altro_esempio
  #  utente = authenticate_with_http_basic { |u, p| u == "admin" && p == "340693" }
  #  if utente == true
  #  else
  #    request_http_basic_authentication
  #  end
  #end

  protected
  def configure_sign_up_params
    authenticate_or_request_with_http_basic("Sign_up") do |username,password|
    username == "admin" && password == "340693"
    end
    #redirect_to home_index_path
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
