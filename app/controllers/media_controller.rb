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
    debugger
    #creo il record da aggiungere
    _record = Hash.new
    _record = { "descrizione" => '' , "foto" => params[:foto]}
    @medium = Medium.new(_record)
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
