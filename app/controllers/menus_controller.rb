#require 'eventmachine'

class MenusController < ApplicationController
  # before_action :set_menu, only: [:show, :edit, :update, :destroy]
  before_action :set_menu, only: [:update, :destroy]

  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
  end

  # GET /menus/new
  def new
    @menu = Menu.new
    @template = Template.all
    render layout: "dashboard"
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.where(user_id: current_user.id, id:params[:id]).first
    @template = Template.all
    #@pluto = @menu.categorie.to_json
    render layout: "dashboard"
  end

  # POST /menus
  # POST /menus.json
  def create
    #a=JSON.parse(params[:categorie]) #arriva sotto forma di stringa dalla view e ristrasformo in hash ruby
    #puts a
    #puts a[1]
    #puts a[1]["id"]
    #debugger
    @menu = Menu.new
    @menu.nome=params[:nome]
    @menu.descrizione=params[:descrizione]
    @menu.categorie=params[:categorie]
    @menu.piatti=params[:piatti]
    #debugger
    @menu.abilitaprezzo=params[:abilitaprezzo]
    @menu.prezzo=params[:prezzo]
    @menu.user_id=current_user.id
    @menu.save
    respond_to do |format|
     format.json { head :no_content }
    end
  end

  def lista_menus_filtra

    #EM.run do
    #  puts "entro controller menu"
    #end
    if params[:nome] != "XXXX"
      @menu = Menu.where("lower(nome) Like lower(?) and user_id=?", "%#{params[:nome]}%",current_user.id)
    else # =="XXXX"
      @menu = Menu.where(user_id: current_user.id)
    end
    @menu ||= Menu.none  #se nullo assegno ActiveRecord
    render 'menus/lista_menus_filtra' , :layout => false
  end

  # def create_old
  #   debugger
  #   @menu = Menu.new(menu_params)
  #
  #   respond_to do |format|
  #     if @menu.save
  #       format.html { redirect_to @menu, notice: 'Menu was successfully created.' }
  #       format.json { render :show, status: :created, location: @menu }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @menu.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /menus/1
  # PATCH/PUT /menus/1.json
  # def update
  #   respond_to do |format|
  #     if @menu.update(menu_params)
  #       format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @menu }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @menu.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end
  def update
    #debugger
    @menu.update_attributes(menu_permetti)
    respond_to do |format|
     format.json { head :no_content }
    end
  end

  # DELETE /menus/1
  # DELETE /menus/1.json
  # def destroy
  #   @menu.destroy
  #   respond_to do |format|
  #     format.html { redirect_to menus_url, notice: 'Menu was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end
  def destroy
    @menu.destroy
    respond_to do |format|
       format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu
      @menu = Menu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_params
      params.require(:menu).permit(:nome, :descrizione, :categorie, :piatti, :user_id)
    end

    def menu_permetti
      #senza menu perchè mi arriva da un form generico
      params.permit(:nome, :descrizione, :categorie, :piatti, :user_id, :abilitaprezzo, :prezzo, :ordine, :template_id)
    end

end
