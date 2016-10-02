class ReceivesController < ApplicationController
  before_action :set_receife, only: [:show, :edit, :update, :destroy]
  before_action :check_superuser ,except: [:registra]

  # GET /receives
  # GET /receives.json
  def index
    @receives = Receive.all
  end

  def registra
    #puts params
    #debugger
    @receife = Receive.new()
    @receife.tipo= params[:tipo_form]
    if params[:tipo_form]=="newsletter"
      @receife.email = params[:newsletter_email]
    else
      @receife.email = params[:contatti_email]
      @receife.nome = params[:contatti_nome]
      @receife.oggetto = params[:contatti_oggetto]
      @receife.messaggio = params[:contatti_messaggio]
    end
    if @receife.save
      #render json: @receife, status: :created  #201
      #format.json { render json: @receife, status: :ok }
      render json: @receife
    else
      render json: @receife.errors, status: :unprocessable_entity #422
    end
  end

  # GET /receives/1
  # GET /receives/1.json
  def show
  end

  # GET /receives/new
  def new
    @receife = Receive.new
  end

  # GET /receives/1/edit
  def edit
  end

  # POST /receives
  # POST /receives.json
  def create
    @receife = Receive.new(receife_params)

    respond_to do |format|
      if @receife.save
        format.html { redirect_to @receife, notice: 'Receive was successfully created.' }
        format.json { render :show, status: :created, location: @receife }
      else
        format.html { render :new }
        format.json { render json: @receife.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receives/1
  # PATCH/PUT /receives/1.json
  def update
    respond_to do |format|
      if @receife.update(receife_params)
        format.html { redirect_to @receife, notice: 'Receive was successfully updated.' }
        format.json { render :show, status: :ok, location: @receife }
      else
        format.html { render :edit }
        format.json { render json: @receife.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receives/1
  # DELETE /receives/1.json
  def destroy
    @receife.destroy
    respond_to do |format|
      format.html { redirect_to receives_url, notice: 'Receive was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receife
      @receife = Receive.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receife_params
      params.require(:receife).permit(:tipo, :email, :nome, :oggetto, :messaggio)
    end

    def check_superuser
      authenticate_or_request_with_http_basic("Sign_up") do |username,password|
      username == "admin" && password == "340693"
      end
    end


end
