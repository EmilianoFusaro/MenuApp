class TemplatesController < ApplicationController
  before_action :set_template, only: [:show, :edit, :update, :destroy]
  before_action :check_superuser ,except: [:detail]


  # GET /templates
  # GET /templates.json
  def index
    @templates = Template.all
  end

  # GET /templates/1
  # GET /templates/1.json
  def show
    @template = Template.find(params[:id])
  end

  # GET /templates/new
  def new
    @template = Template.new
  end

  # GET /templates/1/edit
  def edit
  end

  # POST /templates
  # POST /templates.json
  def create
    #debugger
    @template = Template.new(template_params)
    if @template.save
      #redirect_to @templates_url
      redirect_to :controller=>'templates', :action => 'index'
    else
      render :new
    end
    #respond_to do |format|
    #  if @template.save
    #    format.html { redirect_to @template, notice: 'Template was successfully created.' }
    #    format.json { render :show, status: :created, location: @template }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @template.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /templates/1
  # PATCH/PUT /templates/1.json
  def update
    respond_to do |format|
      if @template.update(template_params)
        format.html { redirect_to @template, notice: 'Il Template è stato aggiornato con successo.' }
        format.json { render :show, status: :ok, location: @template }
      else
        format.html { render :edit }
        format.json { render json: @template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /templates/1
  # DELETE /templates/1.json
  def destroy
    @template.destroy
    respond_to do |format|
      format.html { redirect_to templates_url, notice: 'Il Template è stato eliminato con successo.' }
      format.json { head :no_content }
    end
  end

  def cerca
    debugger
    if params[:descrizione].strip.size==0
      redirect_to templates_url  #forza azione controller
    else
      @templates = Template.where(" descrizione like ? ","%#{params[:descrizione]}%")
      render :index
    end
  end

  private

    #identifica il superutente
    def check_superuser
      authenticate_or_request_with_http_basic("Sign_up") do |username,password|
      username == "admin" && password == "340693"
     end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_template
      @template = Template.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
      params.require(:template).permit(:nome, :descrizione, :img, :ordine, :variabile_a, :variabile_b, :tipo, :sorgente, :sezioni)
    end
end
