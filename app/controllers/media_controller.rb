class MediaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_medium, only: [:show, :edit, :update, :destroy]

  # GET /media
  # GET /media.json
  def index
    #@media = Medium.all
    #Medium.destroy_all  #cancella tutti
    #@media = Medium.find_by_user_id(current_user.id)   #attenzione find non genera una collection e filtra un solo valore
    @media = Medium.where(user_id: current_user.id)
    @media ||= Medium.none  #se nullo assegno ActiveRecord
    #risponde in formato json web api
    #render json:@media , status: :ok
  end

  # GET /media/1
  # GET /media/1.json
  def show
  end

  # GET /media/new
  def new
    @medium = Medium.new
  end

  # GET /media/1/edit
  def edit
  end

  #Aggiunge foto da una chiamata Ajax

  def aggiungi_foto_galleria
    #debugger
    #creo il record da aggiungere
    _record = Hash.new
    # _record = { "descrizione" => '' , "foto" => params[:foto]}
    _record = { "descrizione" => params[:descrizione] , "foto" => params[:foto]}
    @medium = Medium.new(_record)
    @medium.user_id = current_user.id

    respond_to do |format|
     if @medium.save
       #format.html { redirect_to @medium, notice: 'Medium was successfully created.' }
       #format.json { render :show, status: :created, location: @medium }
       #format.json {message: "success" , location: @medium }, status: 200
       #format.json { render json: @medium, status: :created, location: @medium }
       #format.json { message: "success" , status: :created , location: @medium }
       #debugger
       #@percorso = @medium.foto.url(:medium)
       #format.json { render json: @percorso, status: :ok } #forza stato 200
       @foto_salvata = @medium.as_json  #converte activerecord in hash
       @foto_salvata[:percorso] = @medium.foto.url(:medium)
       #anche in questo modo  hash = {:item1 => 1}
       format.json { render json: @foto_salvata, status: :ok } #forza stato 200

     else
       #format.html { render :new }
       #format.json { render json: @medium.errors, status: :unprocessable_entity }
       #format.json { error: "errore"}, status: 400
       format.json { render json: @medium.errors, status: :unprocessable_entity }
       #forza risposta negativa
       #Return a status 404 and an error message in response to an AJAX request, in Rails 3
       #render nothing: true, status: :bad_request
       #render nothing: true, status: 400
       #render text: "This field is required!", status: :bad_request
       #render text: "This field is required!", status: 400
     end
    end


  end

  # POST /media
  # POST /media.json
  def create

    debugger
    #puts medium_params
    #puts "------"
    #puts params
    #debugger
    #medium_params = { "descrizione" => '' , "foto" => params[:medium][:foto][0]} #non puà essere settato in quanto definito in private

    #come fare per più foto
    #pluto = Hash.new
    #pluto = { "descrizione" => '' , "foto" => params[:medium][:foto][0]}
    #@medium = Medium.new(pluto)
    #debuggger

    @medium = Medium.new(medium_params)
    @medium.user_id = current_user.id
    respond_to do |format|
     if @medium.save
       format.html { redirect_to @medium, notice: 'Medium was successfully created.' }
       format.json { render :show, status: :created, location: @medium }
     else
       format.html { render :new }
       format.json { render json: @medium.errors, status: :unprocessable_entity }
     end
    end

    #if @medium.save
    #  # params[:avatar] will be an array.
    #   # you can check total number of photos selected using params[:avatar].count
    #params[:foto].each do |f|
    #  @medium.foto.create(:foto=> f)
    #  # Don't forget to mention :avatar(field name)
    #end
    #end

   #debugger
   #params[:medium].each do |f|
   #  #@media[:foto]
   #    puts "ENTER"
   #    @medium= Medium.new(f.to_h)
   #    @medium.user_id = current_user.id
   #    @medium.save
   #end
   #redirect_to @medium, notice: 'Medium was successfully created.'

end

  # PATCH/PUT /media/1
  # PATCH/PUT /media/1.json
  def update
    respond_to do |format|
      if @medium.update(medium_params)
        format.html { redirect_to @medium, notice: 'Medium was successfully updated.' }
        format.json { render :show, status: :ok, location: @medium }
      else
        format.html { render :edit }
        format.json { render json: @medium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /media/1
  # DELETE /media/1.json
  def destroy
    @medium.destroy
    respond_to do |format|
      format.html { redirect_to media_url, notice: 'Medium was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def modifica_media
    #puts params
    #debugger
    @media = Medium.find(params[:id])
    @media.descrizione=params[:descrizione]
    @media.save
    respond_to do |format|
     format.json { head :no_content }
    end
  end


  def cancella_media
    @media = Medium.find(params[:id])
    @media.destroy
    #respond_to do |format|
    #   format.json { head :no_content }
    #   #format.json { render :json => 'ok' }
    #end
    head :no_content
  end

  def gallery_filtra
    # @media = Medium.where(user_id: current_user.id)
    #if params[:descrizione].strip.size > 0
    if params[:descrizione] != "XXXX"
      @media = Medium.where("lower(descrizione) Like lower(?) and user_id=?", "%#{params[:descrizione]}%",current_user.id)
    else
      @media = Medium.where(user_id: current_user.id)
    end

    @media ||= Medium.none  #se nullo assegno ActiveRecord
    render 'media/gallery_filtra' , :layout => false
  end


  def gallery_scegli
    if params[:descrizione] != "XXXX"
      @media = Medium.where("lower(descrizione) Like lower(?) and user_id=?", "%#{params[:descrizione]}%",current_user.id)
    else
      @media = Medium.where(user_id: current_user.id)
      #@media = Medium.where(user_id: current_user.id).select("descrizione,foto_file_name")  #ActiveRecord filtra determinate colonne
    end
    @media ||= Medium.none  #se nullo assegno ActiveRecord
    #render 'media/gallery_scegli' , :layout => false
    #render json:@media, status: :ok
    #render json:@media.first.foto.url(:medium) , status: :ok
    #foto_media_url metodo mio creato nel model
    render json:@media.to_json(:only =>  [:id,:descrizione], :methods => [:foto_media_url]) , status: :ok
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_medium
      @medium = Medium.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def medium_params
      params.require(:medium).permit(:descrizione, :user_id,:foto)
      #params.require(:medium).permit(:descrizione ,:foto) #utente non deve arrivare dalla chiamata
    end
end
