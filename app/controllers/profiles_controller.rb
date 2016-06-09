class ProfilesController < ApplicationController

  #http_basic_authenticate_with :name => "admin" , :password => "340693" #eseguita su ogni action
  #before_action :check_user

  before_action :check_superuser ,except: [:detail,:payment,:pickup]
  #before_action :check_superuser ,only: [:show, :edit, :update, :destroy ,:index]
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  #Get Visualizza Il Dettaglio Utente
  def detail
      #byebug
      #debugger
    if current_user
      #vai alla vista detail
      #byebug
    else
      redirect_to root_url, alert: "Scusa ma non hai accesso a questo contenuto"
    end
    puts "ciao"
  end

  def payment
    flash[:success] = "Welcome to the Sample App!"
    @pacchetto = params[:pacchetto]
    @periodo = params[:periodo]
    attiva_pacchetto(@pacchetto,@periodo)
    #---procedura x stripe
    #token = params[:stripeToken]
    #begin
    #  charge = Stripe::Charge.create(
    #  :card =>token,
    #  :amount      => PREZZO,
    #  :description => current_user.email,
    #  :currency    => 'eur'
    #  )
    #  @sale= content.sales.create!(email_acquirente: current_user.email)
    #  redirect_to pickup_url(guid: @sale.guid)
    #rescue Stripe::CardError => e
    #  @error = e
    #  redirect_to content_path(content) , notice: @error
    #end
  end

  def pickup
    #@sale = Sale.find_by!(guid: params[:guid])
    #@content = @sale.content
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @nome_profilo = "TEST"
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
    unless @profile.user.nil?
      @nome_profilo = @profile.user.name
    else
      @nome_profilo = ""
    end
  end

  # POST /profiles
  # POST /profiles.json
  def create
    puts "Emiliano:#{params[:nome_profilo]}   #{params}"
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to @profile, notice: 'Profile was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
      if @profile.update(profile_params)
        redirect_to @profile, notice: 'Profile was successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
      redirect_to profiles_url, notice: 'Profile was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:user_id, :tipo, :descrizione)
    end

    def check_superuser
      authenticate_or_request_with_http_basic("Sign_up") do |username,password|
      username == "admin" && password == "340693"
      end
    end

    def attiva_pacchetto(pacchetto,periodo)

     periodo = periodo.to_i
     #---verifico presenza profilo in assenza ne associo uno vuoto
     if current_user.profile.nil?
       p= Profile.new
       p.save
       current_user.profile = p
     end

     if pacchetto == "stampalistino"
       a = current_user.profile
       a.stampalistino = true
       if a.stampalistino_data.nil? || a.stampalistino_data < DateTime.now
         a.stampalistino_data = DateTime.now + periodo.month
       else
         a.stampalistino_data = a.stampalistino_data + periodo.month
       end
       a.save
     end

     if pacchetto == "listinoweb"
       a = current_user.profile
       a.weblistino = true
       if a.weblistino_data.nil? || a.weblistino_data < DateTime.now
         a.weblistino_data = DateTime.now + periodo.month
       else
         a.weblistino_data = a.weblistino_data + periodo.month
       end
       a.save
     end

    end

    #def check_user
    #  #if !!current_user==true
    #    if current_user.profile.tipo != "admin"
    #      redirect_to root_url, alert: "Scusa ma non hai accesso a questo contenuto"
    #    end
    #  #else
    #  #  redirect_to root_url, alert: "Scusa ma non hai accesso a questo contenuto"
    #  #end
    #end
end
