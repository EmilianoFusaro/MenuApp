class AllergensController < ApplicationController
  before_action :set_allergen, only: [:show, :edit, :update, :destroy]


  # GET /allergens
  # GET /allergens.json
  def index
    @allergens = Allergen.all
    #@allergens.to_json
    #render layout: false
    #format.json { render json: @allergens,status: :unprocessable_entity }
    render :json => @allergens
  end

  def lista
    #debugger
    # @allergens = Allergen.all()
    @allergens = Allergen.order(:nome)
    render layout: false
  end

  def lista_filtra
    #@allergens = Allergen.where(:nome => params[:nome]).order(:nome)
    @allergens=Allergen.where("lower(nome) Like lower(?)", "%#{params[:nome]}%")
    render 'allergens/lista' , :layout => false
  end

  # GET /allergens/1
  # GET /allergens/1.json
  def show
  end

  # GET /allergens/new
  def new
    @allergen = Allergen.new
    #respond_to do |format|
    # format.html #new.html.erb
    # format.json { render json: @allergen}
    #end
  end

  # GET /allergens/1/edit
  def edit
  end

  # POST /allergens
  # POST /allergens.json
  def create
    #debugger
    @allergen = Allergen.new(allergen_params)
    #@allergen = Allergen.new

    respond_to do |format|
      if @allergen.save
        #format.html { redirect_to @allergen, notice: 'Allergen was successfully created.' }
        #format.json { render :show, status: :created, location: @allergen }
        #format.json { render :show, status: :created, location: @allergen }  #sostituita poco tempo fa
        format.json { render json: @allergen, status: :created, location: @allergen }
      else
        #format.html { render :new }
        #format.json { render json: @allergen.errors, status: :unprocessable_entity }
        format.json { render json: @allergen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /allergens/1
  # PATCH/PUT /allergens/1.json
  def update
    #respond_to do |format|
      if @allergen.update(allergen_params)
        #format.html { redirect_to @allergen, notice: 'Allergen was successfully updated.' }
        #format.json { render :show, status: :ok, location: @allergen }
        render :show, status: :ok, location: @allergen
      else
        #format.html { render :edit }
        #format.json { render json: @allergen.errors, status: :unprocessable_entity }
        render json: @allergen.errors, status: :unprocessable_entity
      end
    #end
  end

  # DELETE /allergens/1
  # DELETE /allergens/1.json
  def destroy
    @allergen.destroy
    respond_to do |format|
    #format.html { redirect_to allergens_url, notice: 'Allergen was successfully destroyed.' }
    format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_allergen
      @allergen = Allergen.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allergen_params
      params.require(:allergen).permit(:nome, :descrizione, :img, :img1, :img2)
    end

end
