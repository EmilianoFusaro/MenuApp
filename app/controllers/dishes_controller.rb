class DishesController < ApplicationController
  #before_action :set_dish, only: [:show, :edit, :update, :destroy]
  before_action :set_dish, only: [:update, :destroy]
  # layout 'dashboard'
  # GET /dishes
  # GET /dishes.json
  def index
    @dishes = Dish.all
  end

  # GET /dishes/1
  # GET /dishes/1.json
  def show
    @dish = Dish.find_by_id(params[:id])
    render layout: "dashboard"
  end

  # GET /dishes/new
  def new
    @lista_categorie = Category.select(:id,:titolo).where(user_id: current_user.id).order(:ordine)
    @allergeni = Allergen.all
    @dish = Dish.new
    render layout: "dashboard"
  end

  # GET /dishes/1/edit
  def edit
    #@dish = Dish.find_by_id(params[:id]) #senza first restituisce un dataset non un record
    #recuper dati piatto
    @dish = Dish.where(user_id: current_user.id, id:params[:id]).first
    #@categoria = Category.find_by_id(@dish.category)
    @cat = Category.select(:id,:titolo).where(id: @dish.category).first
    #defined? @Category.id
    if @cat.respond_to?(:titolo) #se il metodo id esiste ed ha un valore
      @cat = @cat.titolo
    end
    #recupera lista categoria
    @lista_categorie = Category.select(:id,:titolo).where(user_id: current_user.id).order(:ordine)
    #recupera lista allergeni
    @allergeni = Allergen.all
    render layout: "dashboard"
  end

  # POST /dishes
  # POST /dishes.json
  # CREATE originale
  # def create
  #   debugger
  #   @dish = Dish.new(dish_params)
  #   respond_to do |format|
  #     if @dish.save
  #       format.html { redirect_to @dish, notice: 'Dish was successfully created.' }
  #       format.json { render :show, status: :created, location: @dish }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @dish.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # POST /dishes
  # POST /dishes.json
  # CREATE modificata
  def create
      #puts params
      #debugger
      #@dish = Profile.find_by_user_id(current_user.id)
      @dish = Dish.new
      @dish.nome=params[:nome]
      #@dish.category=params[:category]
      cat = Category.select(:id).where(titolo: params[:category],user_id:current_user.id).first
      if cat !=nil
        @dish.category=cat.id
      else
        @dish.category=nil
      end
      @dish.lista_ingredienti=params[:lista_ingredienti]
      @dish.descrizione=params[:descrizione]
      @dish.lista_allergeni=params[:lista_allergeni]
      @dish.img=params[:img]
      @dish.img1=params[:img1]
      @dish.img2=params[:img2]
      @dish.img3=params[:img3]
      @dish.user_id=current_user.id
      @dish.prezzo=params[:prezzo]
      @dish.save
      respond_to do |format|
       format.json { head :no_content }
      end
  end

  # PATCH/PUT /dishes/1
  # PATCH/PUT /dishes/1.json
  def update_old
    respond_to do |format|
      if @dish.update(dish_params)
        format.html { redirect_to @dish, notice: 'Dish was successfully updated.' }
        format.json { render :show, status: :ok, location: @dish }
      else
        format.html { render :edit }
        format.json { render json: @dish.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    #@dish = Dish.find(params[:id])
    #debugger
    @catid = Category.select(:id).where(titolo: dish_permetti[:category]).first
    @appo_dish_permetti=dish_permetti
    if @catid.respond_to?(:id) #se il metodo id esiste ed ha un valore
      @appo_dish_permetti[:category] = @catid.id
    else
      @appo_dish_permetti[:category] = nil
    end
    #debugger
    @dish.update_attributes(@appo_dish_permetti)
    respond_to do |format|
     format.json { head :no_content }
    end
  end

  # DELETE /dishes/1
  # DELETE /dishes/1.json
  def destroy
    @dish.destroy
    respond_to do |format|
       format.json { head :no_content }
    end
    # respond_to do |format|
    #   format.html { redirect_to dishes_url, notice: 'Dish was successfully destroyed.' }
    #   format.json { head :no_content }
    # end
  end

  #-----------------Action Definite Da Me
  def lista_piatti
    @lista_piatti = Dish.where(user_id: current_user.id).order(:ordine)
    render layout: false
  end


  def lista_piatti_filtra
    categoria = Category.select(:id).where(titolo: params[:categoria],user_id:current_user.id).first
    if categoria !=nil
      categoria=categoria.id
    else
      categoria=nil
    end
    #debugger
    #puts params
    #puts "categoria #{categoria}"
    if params[:nome] != "XXXX" and categoria != nil
      @dish = Dish.where("lower(nome) Like lower(?) and category=(?) and user_id=?", "%#{params[:nome]}%","%#{categoria}%",current_user.id)
    elsif params[:nome] != "XXXX" and categoria == nil
      @dish = Dish.where("lower(nome) Like lower(?) and user_id=?", "%#{params[:nome]}%",current_user.id)
    elsif params[:nome] == "XXXX" and categoria != nil
      puts "ENTER"
      @dish = Dish.where("category = (?) and user_id=?", "#{categoria}",current_user.id)
    else # =="XXXX" and =="TUTTE"
      @dish = Dish.where(user_id: current_user.id)
    end
    @dish ||= Dish.none  #se nullo assegno ActiveRecord
    render 'dishes/lista_piatti_filtra' , :layout => false
  end


  def lista_piatti_seleziona
    #debugger
    @cat_sel = Category.find_by_id(params[:categoria])
    if @cat_sel!=nil
      @cat_id=@cat_sel.id
      @cat_sel=@cat_sel.titolo
    else
      @cat_id=nil
      @cat_sel=nil
    end
    if params[:nome] != "XXXX" and params[:categoria] != "TUTTE"
      @dish = Dish.where("lower(nome) Like lower(?) and lower(category) Like lower(?) and user_id=?", "%#{params[:nome]}%","%#{params[:categoria]}%",current_user.id)
    elsif params[:nome] != "XXXX" and params[:categoria] == "TUTTE"
      @dish = Dish.where("lower(nome) Like lower(?) and user_id=?", "%#{params[:nome]}%",current_user.id)
    elsif params[:nome] == "XXXX" and params[:categoria] != "TUTTE"
      @dish = Dish.where("lower(category) Like lower(?) and user_id=?", "%#{params[:categoria]}%",current_user.id)
    else # =="XXXX" and =="TUTTE"
      @dish = Dish.where(user_id: current_user.id)
    end
    @dish ||= Dish.none  #se nullo assegno ActiveRecord
    render 'dishes/lista_piatti_seleziona' , :layout => false
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dish
      @dish = Dish.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dish_params
      params.require(:dish).permit(:nome, :descrizione, :category, :lista_ingredienti, :img, :img1, :img2, :img3, :user_id)
    end

    def dish_permetti
      #senza dish perchè mi arriva da un form generico
      params.permit(:nome, :descrizione, :lista_ingredienti, :img, :img1, :img2, :img3, :user_id, :ordine, :category, :lista_allergeni, :prezzo)
      #params.permit(:id, :nome, :descrizione, :lista_ingredienti, :img, :img1, :img2, :img3, :user_id, :ordine, :category, :lista_allergeni, :prezzo)
    end

end
