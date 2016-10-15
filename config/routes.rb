Rails.application.routes.draw do

  resources :receives do
    collection do
      post '/registra' => "receives#registra"
    end
  end

  resources :menus

  resources :media do
    collection  do
      post '/aggiungi_foto_galleria' => "media#aggiungi_foto_galleria"
      get '/gallery_filtra/:descrizione' , to: 'media#gallery_filtra'
      get '/gallery_scegli/:descrizione' , to: 'media#gallery_scegli'
      put '/modifica_media/:id' => "media#modifica_media"
      delete '/cancella_media/:id' => "media#cancella_media"
    end
  end

  get 'dashboard/index'
  get 'dashboard/azienda'
  get 'dashboard/media'
  get 'dashboard/dishes'
  # get 'dashboard/lista_piatti'
  get 'dashboard/lista_categorie'
  post 'dashboard/inserisci_categoria' => "dashboard#inserisci_categoria"
  delete 'dashboard/cancella_categoria/:id' => "dashboard#cancella_categoria"
  put 'dashboard/aggiorna_ordine_categoria' => "dashboard#aggiorna_ordine_categoria"
  put 'dashboard/modifica_categoria/:id' => "dashboard#modifica_categoria"
  get 'dashboard/stampa'

  resources :categories do
    collection do
      get  'gestione'
      #post 'rigenera'
    end
  end

  resources :allergens do
    collection do
      get 'lista'
      get '/lista_filtra/:nome' , to: 'allergens#lista_filtra'
    end
  end

  resources :ingredients

  resources :dishes do
    collection do
      get 'lista_piatti'
      get '/lista_piatti_filtra/:nome&:categoria' , to: 'dishes#lista_piatti_filtra'
    end
  end

  resources :profiles do
    collection do
      get 'detail'
      get 'cerca'
      #get 'profiles/cerca/:descrizione' => "profiles#descrizone"
      #post '/compra/:slug&:prezzo', to: 'profiles#payment' , as: :compra
      #post '/compra/:slug', to: 'profiles#payment' , as: :compra
      post '/compra/:pacchetto&:periodo', to: 'profiles#payment' , as: :compra
      get '/pickup/:guid', to: 'profiles#pickup', as: :pickup
      put '/aggiungi_dati_azienda' => "profiles#aggiungi_dati_azienda"
      put '/aggiorna_utente' => "profiles#aggiorna_utente"
      #delete '/cancella_profilo/:id' => "profiles#cancella_profilo"
    end
  end

  #devise_for :users
  root to: "home#index"
  get 'home/index'
  get 'home/vietato'

  get 'allergeni/gestione'


  get 'home/testindex'   #route pagina di prova

  #controller per la registrazione (Attenzione devo aggiungere questi controller al route se voglio farli funzionare)
  #xdevise_for :users, controllers: { registrations: "users/registrations" }
  devise_for :users, controllers: { registrations: "users/registrations" , sessions: "users/sessions" }
  #mi permette il logout e ritorna alla index
  devise_scope :user do
   get '/users/sign_out' => 'devise/sessions#destroy'
 end



#gestione errore
#if Rails.env.production?
#get '404', :to => 'application#page_not_found'
#end


  #controller per il login
  #devise_for :users, controllers: { sessions: "users/sessions" }

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
