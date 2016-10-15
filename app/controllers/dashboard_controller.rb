class DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :verifica_profilo

  layout 'dashboard'

  def index
    @menu_creati=User.find(current_user.id).menus.count
    @categorie_create=User.find(current_user.id).categories.count
    @piatti_creati=User.find(current_user.id).dishes.count
    @ingredienti_creati=User.find(current_user.id).ingredients.count
  end

  def azienda
    @azienda = Profile.find_by_user_id(current_user.id)
  end

  def media
    #selezione le foto dell'utente loggato
    @media = Medium.where(user_id: current_user.id)
    @media ||= Medium.none
  end

  def dishes #Piatti
      @lista_categorie = Category.select(:id,:titolo).where(user_id: current_user.id).order(:ordine)
  end

  def lista_categorie
    #questa query limita il filtro ad un risultato
    #@lista_categorie = Category.find_by(user_id: current_user.id)
    @lista_categorie = Category.where(user_id: current_user.id).order(:ordine)
    #specifico senza layout
    render layout: false
    # specifico senza layout ma vista da renderizzare
    # render 'dashboard/_lista_categorie' , :layout => false
  end

  #def lista_piatti
  #  @lista_piatti = Dish.where(user_id: current_user.id).order(:ordine)
  #  render layout: false
  #end

  def inserisci_categoria
    @categoria = Category.new(categoria_params)
    @categoria.user_id = current_user.id

    respond_to do |format|
      if @categoria.save
        format.json { render json: @categoria, status: :created, location: @categoria }
      else
        format.json { render json: @categoria.errors, status: :unprocessable_entity }
      end
    end
  end


  def cancella_categoria
    @categoria = Category.find(params[:id])
    @categoria.destroy
    respond_to do |format|
       format.json { head :no_content }
      # format.json { render :json => 'ok' }
    end
  end


  def stampa
     # Load the html to convert to PDF
     #html = File.read("#{Rails.root}/public/prova.html")
     html = File.read("#{Rails.root}/public/pluto.html")
     # Create a new kit and define page size to be US letter
     #kit = PDFKit.new(html, :page_size => 'Letter')
     kit = PDFKit.new(html, :page_size => 'A4', :margin_top => '0.1in' ,:margin_right=>'0.1in',:margin_left=>'0.1in' ,:margin_bottom=>'0.1in')
     #kit = PDFKit.new(html, :page_size => 'Letter', :margin_top => '0.1in' ,:margin_right => '0.1in',:margin_left => '0.1in')
     #kit = PDFKit.new(html, page_width: '169.33', page_height: '95.25')
     # Load our stylesheet into the kit to have colors & formatting
     #kit.stylesheets << "#{Rails.root}/public/styles.css"
     #kit.stylesheets << "#{Rails.root}/public/stile.css"
     # Save the html to a PDF file
     kit.to_file("#{Rails.root}/public/example.pdf")
     # Render the html
     render :text => html
     #render 'dashboard/index'  #ritorno alla home
  end


  def aggiorna_ordine_categoria
    #puts params
    #puts params[:_json][1].class
    #puts JSON.parse(params[:_json][1])
    #puts JSON.parse(params[:_json][1])
    #puts params[:_json][0]["id"]

    #debugger
    unless params[:_json].nil?
      params[:_json].each do |riga|
        Category.where(:id=>riga["id"]).update_all(:ordine=>riga["ordine"])
      end
    end
    #puts params[:_json] #.to_a
    #puts JSON.parse(params)
    #render layout: false
    respond_to do |format|
     format.json { head :no_content }
     #format.json { render :json => 'ok' }
    end
  end


  def modifica_categoria
    #puts params[:category][:titolo]
    @categoria = Category.find(params[:id])
    @categoria.titolo=params[:category][:titolo]
    @categoria.save
    respond_to do |format|
     format.json { head :no_content }
    end
  end


private
  def categoria_params
    params.require(:category).permit(:titolo, :descrizione, :foto, :ordine)
  end

  def verifica_profilo
    #debugger
    if current_user.profile.stampalistino == false and current_user.profile.weblistino == false
      #redirect_to detail_profiles
      #render plain: "404 Not Found dove cazzo vai!", status: 404
      #render "handle_errors/page_404", status: 404
      #raise ActionController::RoutingError.new('Not Found')
      #funziona su pagina in public
      #render file: "#{Rails.root}/public/404", layout: false, status: :not_found
      #redirect_to :controller=>'profiles', :action => 'detail', :id => @tip.permalink
      redirect_to :controller=>'profiles', :action => 'detail'
    end
  end

end
