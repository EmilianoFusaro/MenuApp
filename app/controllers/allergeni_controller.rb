class AllergeniController < ApplicationController
  before_action :authenticate_user!

  layout 'gestione'
   def gestione
     #render layout: gestione
   end

   private
   def autentica
     unless current_user
       render '/users/sign_in'
     end
   end

end
